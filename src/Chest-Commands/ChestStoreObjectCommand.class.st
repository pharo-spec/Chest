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

{ #category : #initialization }
ChestStoreObjectCommand >> buildChoicePresenter [

	| choicePresenter |
	choicePresenter := ChestTableWithContentPresenter new.
	choicePresenter confirmButton action: [ 
		| chest objectName |
		chest := choicePresenter chestsTable selectedItem.
		objectName := choicePresenter inputField text.
		[ 
		self
			storeSelectionInChest: chest
			withName: objectName
			replacing: false ]
			on: ChestKeyAlreadyInUseError
			do: [ 
				((choicePresenter confirm:
					  (choicePresenter warningNamingObjectInChest: objectName)) 
					 onAccept: [ 
						 self
							 storeSelectionInChest: chest
							 withName: objectName
							 replacing: true ]) openDialogWithParent:
					choicePresenter chestContentTable ].
		choicePresenter window close ].
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

{ #category : #execution }
ChestStoreObjectCommand >> storeResult: result intoChest: chest withName: objectName replacing: replacingBoolean [

	replacingBoolean ifTrue: [ chest removeObjectNamed: objectName ].

	objectName = chest nextDefaultNameForObject
		ifTrue: [ self storeObject: result intoChest: chest ]
		ifFalse: [ 
		self storeObject: result intoChest: chest withName: objectName ]
]

{ #category : #execution }
ChestStoreObjectCommand >> storeSelectionInChest: aChest withName: objectName replacing: replacingBoolean [

	self evaluateSelectionAndDo: [ :result | 
		self storeResult: result intoChest: aChest withName: objectName replacing: replacingBoolean
	]
]
