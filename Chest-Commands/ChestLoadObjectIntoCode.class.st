"
Command that allows to load an object or several objects from a chest into a code presenter in a playground or in a debugger.
"
Class {
	#name : #ChestLoadObjectIntoCode,
	#superclass : #ChestCommand,
	#category : #'Chest-Commands'
}

{ #category : #'accessing - defaults' }
ChestLoadObjectIntoCode class >> defaultDescription [

	^ 'Load an object from a chest into a code presenter'
]

{ #category : #initialization }
ChestLoadObjectIntoCode class >> defaultIconName [

	^ #group
]

{ #category : #'accessing - defaults' }
ChestLoadObjectIntoCode class >> defaultName [

	^ 'Load object from chest'
]

{ #category : #default }
ChestLoadObjectIntoCode class >> defaultShortcutKey [

	^ $c meta , $l meta
]

{ #category : #accessing }
ChestLoadObjectIntoCode class >> variableTag [

	^ #comesFromChest
]

{ #category : #initialization }
ChestLoadObjectIntoCode >> buildChoicePresenter [

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
			(context interactionModel hasBindingOf: assoc key)
				ifTrue: [ 
					self
						warnUserWhenDeletingBindingWithKey: assoc key
						withNewValue: assoc value ]
				ifFalse: [ 
				self loadIntoContextObject: assoc value named: assoc variableName ] ].
		choicePresenter window close ].

	^ choicePresenter
]

{ #category : #testing }
ChestLoadObjectIntoCode >> canBeExecuted [

	^ self isVisibleForContext: context
]

{ #category : #execution }
ChestLoadObjectIntoCode >> execute [

	| choicePresenter |
	choicePresenter := self buildChoicePresenter.
	choicePresenter open
]

{ #category : #testing }
ChestLoadObjectIntoCode >> isVisibleForContext: aCodePresenter [

	^ aCodePresenter interactionModel isNotNil and: [ 
		  aCodePresenter interactionModel class allSelectors 
			  identityIncludes: #addBinding: ]
]

{ #category : #'as yet unclassified' }
ChestLoadObjectIntoCode >> loadIntoContextObject: anObject named: objectName [

	| metalink interactionModel |
	interactionModel := self context interactionModel.
	interactionModel addBinding:
		((WorkspaceVariable key: objectName value: anObject)
			 propertyAt: self variableTag put: true;
			 yourself)
	"metalink := MetaLink new.
	metalink arguments: #(receiver arguments).
	metalink metaObject: [:receiver :arguments|  ]."
]

{ #category : #accessing }
ChestLoadObjectIntoCode >> variableTag [ 

	^ self class variableTag
]

{ #category : #'as yet unclassified' }
ChestLoadObjectIntoCode >> warnUserWhenDeletingBindingWithKey: key withNewValue: newValue [

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
