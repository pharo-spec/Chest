Class {
	#name : #ChestLoadObjectIntoCode,
	#superclass : #CmCommand,
	#instVars : [
		'choicePresenter'
	],
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

	^ 'Load object from a chest into a code'
]

{ #category : #default }
ChestLoadObjectIntoCode class >> defaultShortcutKey [

	^ $c meta, $l meta
]

{ #category : #initialization }
ChestLoadObjectIntoCode >> buildChoicePresenter [

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
				self
					loadIntoContextObject: objectsAssociations first value
					named: objectName ]
			ifFalse: [ 
				objectsAssociations isEmpty ifTrue: [ 
					objectsAssociations := chest contents associations asOrderedCollection ].
				objectsAssociations do: [ :assoc | 
					self loadIntoContextObject: assoc value named: assoc key ] ].
		choicePresenter window close ].
	choicePresenter layout: choicePresenter commandLayout
]

{ #category : #execution }
ChestLoadObjectIntoCode >> execute [

	choicePresenter open
]

{ #category : #initialization }
ChestLoadObjectIntoCode >> initialize [

	super initialize.
	self buildChoicePresenter 
]

{ #category : #testing }
ChestLoadObjectIntoCode >> isVisibleForContext: aCodePresenter [

	^ aCodePresenter interactionModel isNotNil and: [ aCodePresenter interactionModel allSelectors indexOf: #addBinding: > 0 ]
]

{ #category : #'as yet unclassified' }
ChestLoadObjectIntoCode >> loadIntoContextObject: anObject named: objectName [

	| metalink interactionModel |
	interactionModel := self context interactionModel.
	interactionModel addBinding: (WorkspaceVariable key: objectName value: anObject)
	"metalink := MetaLink new.
	metalink arguments: #(receiver arguments).
	metalink metaObject: [:receiver :arguments|  ]."
]
