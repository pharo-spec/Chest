"
Command that allows to store the result of the evaluation of the selected expression in a `SpCodePresenter` into a chest.
"
Class {
	#name : #ChestStoreObjectCommand,
	#superclass : #SpCodeSelectionCommand,
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

	^ $c meta , $s meta
]

{ #category : #'as yet unclassified' }
ChestStoreObjectCommand >> blockToEvaluateToStoreResult: result intoChest: chest withName: objectName withPresenter: choicePresenter [

	^ [ 
	  objectName = chest nextDefaultNameForObject
		  ifTrue: [ self storeObject: result intoChest: chest ]
		  ifFalse: [ 
		  self storeObject: result intoChest: chest withName: objectName ].
	  choicePresenter window close ]
]

{ #category : #initialization }
ChestStoreObjectCommand >> buildChoicePresenter [

	| choicePresenter |
	choicePresenter := ChestTableWithContentPresenter new.
	choicePresenter confirmButton action: [ 
		| chest objectName |
		chest := choicePresenter chestsTable selectedItem.
		objectName := choicePresenter inputField text.
		self evaluateSelectionAndDo: [ :result | 
			(self
				 blockToEvaluateToStoreResult: result
				 intoChest: chest
				 withName: objectName
				 withPresenter: choicePresenter)
				on: ChestKeyAlreadyInUseError
				do: [ 
					((choicePresenter confirm:
						  (choicePresenter warningNamingObjectInChest: objectName)) 
						 onAccept: [ 
							 chest removeObjectNamed: objectName.
							 (self
								  blockToEvaluateToStoreResult: result
								  intoChest: chest
								  withName: objectName
								  withPresenter: choicePresenter) value ]) 
						openDialogWithParent: choicePresenter chestContentTable ] ] ].
	choicePresenter layout: choicePresenter storeCommandLayout.
	^ choicePresenter
]

{ #category : #execution }
ChestStoreObjectCommand >> execute [

	| choicePresenter |
	choicePresenter := self buildChoicePresenter.
	choicePresenter open
]

{ #category : #execution }
ChestStoreObjectCommand >> storeObject: result intoChest: chest [

	chest ifNotNil: [ chest add: result ]
]

{ #category : #execution }
ChestStoreObjectCommand >> storeObject: result intoChest: chest withName: objectName [

	chest ifNotNil: [ chest at: objectName put: result ]
]
