"
Command that allows to load an object or several objects from a chest into a code presenter in a playground or in a debugger.
"
Class {
	#name : #ChestLoadObjectIntoCode,
	#superclass : #CmCommand,
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

{ #category : #initialization }
ChestLoadObjectIntoCode >> buildChoicePresenter [

	| choicePresenter |
	choicePresenter := ChestTableWithContentPresenter new.
	choicePresenter chestContentTable beMultipleSelection.
	choicePresenter confirmButton action: [ 
		| chest objectName objectsAssociations |
		chest := choicePresenter chestsTable selectedItem.
		objectName := choicePresenter inputField text.
		objectsAssociations := choicePresenter chestContentTable
			                       selectedItems.
		objectsAssociations size = 1
			ifTrue: [ 
				(context interactionModel hasBindingOf: objectName)
					ifTrue: [ 
						self
							warnUserWhenDeletingBindingWithKey: objectName
							withNewValue: objectsAssociations first value ]
					ifFalse: [ 
						self
							loadIntoContextObject: objectsAssociations first value
							named: objectName ] ]
			ifFalse: [ 
				objectsAssociations isEmpty ifTrue: [ 
					objectsAssociations := chest contents associations
						                       asOrderedCollection ].
				objectsAssociations do: [ :assoc | 
					(context interactionModel hasBindingOf: assoc key)
						ifTrue: [ 
							self
								warnUserWhenDeletingBindingWithKey: assoc key
								withNewValue: assoc value ]
						ifFalse: [ 
						self loadIntoContextObject: assoc value named: assoc key ] ] ].
		choicePresenter window close ].
	choicePresenter layout: choicePresenter storeCommandLayout.
	^ choicePresenter
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
		  aCodePresenter interactionModel allSelectors indexOf:
			  #addBinding: > 0 ]
]

{ #category : #'as yet unclassified' }
ChestLoadObjectIntoCode >> loadIntoContextObject: anObject named: objectName [

	| metalink interactionModel |
	interactionModel := self context interactionModel.
	interactionModel addBinding:
		(WorkspaceVariable key: objectName value: anObject)
	"metalink := MetaLink new.
	metalink arguments: #(receiver arguments).
	metalink metaObject: [:receiver :arguments|  ]."
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
