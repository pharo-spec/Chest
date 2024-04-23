"
Command that allows to store the result of the evaluation of the selected expression in a `SpCodePresenter` into a chest.
"
Class {
	#name : 'ChestStoreObjectCommand',
	#superclass : 'SpCodeSelectionCommand',
	#category : 'Chest-Commands',
	#package : 'Chest-Commands'
}

{ #category : 'accessing - defaults' }
ChestStoreObjectCommand class >> defaultDescription [

	^ 'Store the result of the selected expression in the chest of your choice'
]

{ #category : 'accessing - defaults' }
ChestStoreObjectCommand class >> defaultIconName [

	^ #group
]

{ #category : 'accessing - defaults' }
ChestStoreObjectCommand class >> defaultName [

	^ 'Store object in a chest'
]

{ #category : 'initialization' }
ChestStoreObjectCommand >> buildChoicePresenter [

	| choicePresenter |
	choicePresenter := ChestTableWithContentPresenter new.
	choicePresenter confirmButton action: [
		| chest objectName selectorToSendToSelection |
		chest := choicePresenter chestsTable selectedItem.
		objectName := choicePresenter inputField text.
		selectorToSendToSelection := #yourself.
		choicePresenter buttonShallowCopy state ifTrue: [
			selectorToSendToSelection := #shallowCopy ].
		choicePresenter buttonDeepCopy state ifTrue: [
			selectorToSendToSelection := #copy ].
		[
		self
			storeSelectionInChest: chest
			withName: objectName
			withSelector: selectorToSendToSelection
			replacing: false ]
			on: ChestKeyAlreadyInUseError
			do: [
				((choicePresenter confirm:
					  (choicePresenter warningNamingObjectInChest: objectName))
					 onAccept: [
						 self
							 storeSelectionInChest: chest
							 withName: objectName
							 withSelector: selectorToSendToSelection
							 replacing: true ]) openDialogWithParent:
					choicePresenter chestContentTable ].
		choicePresenter window close ].
	choicePresenter layout: choicePresenter storeCommandLayout.
	^ choicePresenter
]

{ #category : 'execution' }
ChestStoreObjectCommand >> execute [

	| choicePresenter |
	choicePresenter := self buildChoicePresenter.
	choicePresenter open
]

{ #category : 'execution' }
ChestStoreObjectCommand >> storeObject: result intoChest: chest [

	chest ifNotNil: [ chest add: result ]
]

{ #category : 'execution' }
ChestStoreObjectCommand >> storeObject: result intoChest: chest withName: objectName [

	chest ifNotNil: [ chest at: objectName put: result ]
]

{ #category : 'execution' }
ChestStoreObjectCommand >> storeResult: result intoChest: chest withName: objectName replacing: replacingBoolean [

	replacingBoolean ifTrue: [ chest removeObjectNamed: objectName ].

	objectName = chest nextDefaultNameForObject
		ifTrue: [ self storeObject: result intoChest: chest ]
		ifFalse: [ 
		self storeObject: result intoChest: chest withName: objectName ]
]

{ #category : 'execution' }
ChestStoreObjectCommand >> storeSelectionInChest: aChest withName: objectName withSelector: selectorSentToSelectionBeforeStoring replacing: replacingBoolean [

	self evaluateSelectionAndDo: [ :result |
		| storedResult |
		storedResult := result
			                perform: selectorSentToSelectionBeforeStoring
			                withArguments: #(  ).
		self
			storeResult: storedResult
			intoChest: aChest
			withName: objectName
			replacing: replacingBoolean ]
]
