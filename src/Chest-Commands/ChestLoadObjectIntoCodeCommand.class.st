"
Command that allows to load an object or several objects from a chest into a code presenter in a playground or in a debugger.
"
Class {
	#name : 'ChestLoadObjectIntoCodeCommand',
	#superclass : 'ChestCommand',
	#category : 'Chest-Commands',
	#package : 'Chest-Commands'
}

{ #category : 'accessing - defaults' }
ChestLoadObjectIntoCodeCommand class >> defaultDescription [

	^ 'Load an object from a chest into a code presenter'
]

{ #category : 'initialization' }
ChestLoadObjectIntoCodeCommand class >> defaultIconName [

	^ #group
]

{ #category : 'accessing - defaults' }
ChestLoadObjectIntoCodeCommand class >> defaultName [

	^ 'Load object from chest'
]

{ #category : 'testing' }
ChestLoadObjectIntoCodeCommand class >> isVisibleForContext: aCodePresenter [

	^ aCodePresenter canLoadBindings
]

{ #category : 'accessing' }
ChestLoadObjectIntoCodeCommand class >> variableTag [

	^ Chest comesFromChestVariableTag
]

{ #category : 'initialization' }
ChestLoadObjectIntoCodeCommand >> buildChoicePresenter [

	| choicePresenter |
	choicePresenter := ChestTableWithContentPresenter new.
	choicePresenter chestContentTable beMultipleSelection.
	choicePresenter layout: choicePresenter loadCommandLayout.
	choicePresenter confirmButton action: [ 
		| chest selectedIndexes chestContentTable |
		chest := choicePresenter chestsTable selectedItem.
		chestContentTable := choicePresenter chestContentTable.
		selectedIndexes := chestContentTable selectionMode selectedIndexes.
		selectedIndexes isEmpty ifTrue: [ 
			chestContentTable selectIndexes:
				(1 to: chestContentTable items size) ].
		selectedIndexes do: [ :index | 
			| assoc |
			assoc := chestContentTable items at: index.
			self loadAssocIntoContext: assoc ].
		choicePresenter window close ].

	^ choicePresenter
]

{ #category : 'testing' }
ChestLoadObjectIntoCodeCommand >> canBeExecuted [

	^ self isVisibleForContext: context
]

{ #category : 'execution' }
ChestLoadObjectIntoCodeCommand >> execute [

	| choicePresenter |
	choicePresenter := self buildChoicePresenter.
	choicePresenter open
]

{ #category : 'testing' }
ChestLoadObjectIntoCodeCommand >> isVisibleForContext: aCodePresenter [

	^ aCodePresenter interactionModel isNotNil and: [ 
		  aCodePresenter interactionModel class allSelectors 
			  identityIncludes: #addBinding: ]
]

{ #category : 'execution' }
ChestLoadObjectIntoCodeCommand >> loadAssocIntoContext: assoc [

	(context interactionModel hasBindingOf: assoc variableName)
		ifTrue: [
			self
				warnUserWhenDeletingBindingWithKey: assoc variableName
				withNewValue: assoc value ]
		ifFalse: [
		self loadIntoContextObject: assoc value named: assoc variableName ]
]

{ #category : 'private - commands' }
ChestLoadObjectIntoCodeCommand >> loadIntoContextObject: anObject named: objectName [

	| interactionModel |
	interactionModel := self context interactionModel.
	interactionModel addBinding:
		((WorkspaceVariable key: objectName value: anObject)
			 propertyAt: self variableTag put: true;
			 yourself)
]

{ #category : 'accessing' }
ChestLoadObjectIntoCodeCommand >> variableTag [ 

	^ self class variableTag
]

{ #category : 'private - commands' }
ChestLoadObjectIntoCodeCommand >> warnUserWhenDeletingBindingWithKey: key withNewValue: newValue [

	| presenter |
	presenter := ChestRequestDialogPresenter
		             confirm: 'A binding for a variable named "' , key
			             ,
			             '" already exists. Are you sure you want to proceed ?'
		             onAccept: [ 
		             self loadIntoContextObject: newValue named: key ]
		             onCancel: [ "On cancel, we don't load anything" ].

	(context newPopover
		 presenter: presenter;
		 relativeTo: context;
		 bePositionRight;
		 yourself) popup
]
