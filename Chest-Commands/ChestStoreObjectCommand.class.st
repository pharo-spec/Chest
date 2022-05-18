Class {
	#name : #ChestStoreObjectCommand,
	#superclass : #SpCodeSelectionCommand,
	#instVars : [
		'choicePresenter'
	],
	#category : #'Chest-Commands'
}

{ #category : #'accessing - defaults' }
ChestStoreObjectCommand class >> defaultDescription [

	^ 'Store the result of the selected expression in the chest of your choice'
]

{ #category : #'accessing - defaults' }
ChestStoreObjectCommand class >> defaultIconName [

	^ #group
]

{ #category : #'accessing - defaults' }
ChestStoreObjectCommand class >> defaultName [

	^ 'Store object in a chest'
]

{ #category : #'accessing - defaults' }
ChestStoreObjectCommand class >> defaultShortcutKey [

	^ $c meta, $s meta
]

{ #category : #'as yet unclassified' }
ChestStoreObjectCommand >> blockToEvaluateToStoreResult: result intoChest: chest withName: objectName [

	^ [ objectName = chest nextDefaultNameForObject
				ifTrue: [ self storeObject: result intoChest: chest ]
				ifFalse: [ 
				self storeObject: result intoChest: chest withName: objectName ] .  choicePresenter window close. ]
]

{ #category : #initialization }
ChestStoreObjectCommand >> buildChoicePresenter [

	choicePresenter := ChestTableWithContentPresenter new.
	choicePresenter confirmButton action: [ 
		| chest objectName |
		chest := choicePresenter chestsTable selectedItem.
		objectName := choicePresenter inputField text.
		self evaluateSelectionAndDo: [ :result | 
			(self
				 blockToEvaluateToStoreResult: result
				 intoChest: chest
				 withName: objectName)
				on: ChestKeyAlreadyInUseError
				do: [ 
					((choicePresenter confirm:
						  (choicePresenter warningNamingObjectInChest: objectName)) 
						 onAccept: [ 
							 chest removeObjectNamed: objectName.
							 self
								 blockToEvaluateToStoreResult: result
								 intoChest: chest
								 withName: objectName ]) openDialogWithParent:
						choicePresenter chestContentTable ] ] ].
	choicePresenter layout: choicePresenter commandLayout
]

{ #category : #execution }
ChestStoreObjectCommand >> execute [

	choicePresenter open
]

{ #category : #initialization }
ChestStoreObjectCommand >> initialize [
	super initialize.
	self buildChoicePresenter.
	
]

{ #category : #execution }
ChestStoreObjectCommand >> storeObject: result intoChest: chest [

	chest ifNotNil: [ chest add: result ]
]

{ #category : #execution }
ChestStoreObjectCommand >> storeObject: result intoChest: chest withName: objectName [

	chest ifNotNil: [ chest at: objectName put: result ]
]
