"
Minimal subpresenter used by `ChestPresenter` and some commands in the `Chest-Commands` package, that displays all chests with their contents, and a text input field to name different entities according to the context.
"
Class {
	#name : #ChestTableWithContentPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'chestsTable',
		'chestContentsTable',
		'inputField',
		'confirmActionBar',
		'confirmButton',
		'cancelButton',
		'chestTableContainer',
		'chestContentTableContainer'
	],
	#category : #Chest
}

{ #category : #accessing }
ChestTableWithContentPresenter >> cancelButton [

	^ cancelButton
]

{ #category : #updating }
ChestTableWithContentPresenter >> chestContentTable [

	^ chestContentsTable
]

{ #category : #accessing }
ChestTableWithContentPresenter >> chestContentTableContainer [

	^ chestContentTableContainer
]

{ #category : #accessing }
ChestTableWithContentPresenter >> chestTableContainer [

	^ chestTableContainer
]

{ #category : #accessing }
ChestTableWithContentPresenter >> chestTableTransmitBlock [

	^ [ :aChest | 
	  aChest
		  ifNotNil: [ 
			  self updateChestContentTableForChest: aChest.
			  chestContentsTable items ifNotEmpty: [ 
				  chestContentsTable selectIndex: 1 ].
			  inputField text: aChest nextDefaultNameForObject ]
		  ifNil: [ 
			  chestContentsTable items: {  } asOrderedCollection.
			  inputField text: '' ] ]
]

{ #category : #updating }
ChestTableWithContentPresenter >> chestsTable [

	^ chestsTable
]

{ #category : #'ui requests' }
ChestTableWithContentPresenter >> confirm: aWarning [

	^ SpConfirmDialog new
		  title: 'Warning !';
		  label: aWarning;
		  acceptLabel: 'Yes';
		  cancelLabel: 'No'
]

{ #category : #accessing }
ChestTableWithContentPresenter >> confirmActionBar [

	^ confirmActionBar
]

{ #category : #accessing }
ChestTableWithContentPresenter >> confirmButton [

	^ confirmButton
]

{ #category : #initialization }
ChestTableWithContentPresenter >> connectPresenters [

	chestsTable
		transmitDo: self chestTableTransmitBlock;
		selectFirst
]

{ #category : #updating }
ChestTableWithContentPresenter >> defaultLayout [

	^ SpPanedLayout newHorizontal
		  add: chestTableContainer;
		  add: chestContentTableContainer;
		  yourself
]

{ #category : #updating }
ChestTableWithContentPresenter >> eventChestRemoved: aChestRemovedAnnouncement [

	self updateChestsTable
]

{ #category : #updating }
ChestTableWithContentPresenter >> eventContentOfChestUpdated: aChestUpdatedAnnouncement [

	| currentlySelectedChest updatedChest |
	updatedChest := aChestUpdatedAnnouncement updatedChest.
	currentlySelectedChest := chestsTable selectedItem.
	currentlySelectedChest == updatedChest ifTrue: [ 
		self updateChestContentTableForChest: updatedChest ]
]

{ #category : #updating }
ChestTableWithContentPresenter >> eventNewChest: aChestCreatedAnnouncement [

	self updateChestsTable
]

{ #category : #updating }
ChestTableWithContentPresenter >> initialize [

	super initialize.
	self subscribeToChestAnnouncer
]

{ #category : #initialization }
ChestTableWithContentPresenter >> initializePresenters [

	chestsTable := self makeChestsTable.
	chestTableContainer := SpBoxLayout newVertical
		                       add: self chestsTable;
		                       yourself.
	chestContentsTable := self makeChestContentsTable.
	chestContentTableContainer := SpBoxLayout newVertical
		                              add: self chestContentTable;
		                              yourself.
	chestsTable selectIndex: 1.
	inputField := self makeInputField.
	confirmActionBar := self makeConfirmActionBar.

	self layout: self defaultLayout
]

{ #category : #initialization }
ChestTableWithContentPresenter >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter whenClosedDo: [ self unsubscribeFromChestAnnouncer ]
]

{ #category : #accessing }
ChestTableWithContentPresenter >> inputField [

	^ inputField
]

{ #category : #layout }
ChestTableWithContentPresenter >> loadCommandLayout [

	self chestTableContainer
		removeAll;
		add: inputField;
		add: #chestsTable.
	self chestContentTableContainer
		removeAll;
		add: #chestContentsTable.

	^ SpBoxLayout newVertical
		  add: self defaultLayout;
		  add: #confirmActionBar;
		  yourself
]

{ #category : #'presenter building' }
ChestTableWithContentPresenter >> makeChestContentsTable [

	^ self newTable
		  addColumn: ((SpStringTableColumn
				    title: 'Name'
				    evaluated: [ :association | association key ]) width: 40);
		  addColumn: (SpStringTableColumn
				   title: 'Object'
				   evaluated: [ :association | association value asString ]);
		  items: #(  ) asOrderedCollection
]

{ #category : #'presenter building' }
ChestTableWithContentPresenter >> makeChestsTable [

	^ self newList
		  items: Chest allChests;
		  display: [ :chest | chest name ];
		  
		  sortingBlock: [ :chest1 :chest2 | chest1 name < chest2 name ];
		  yourself
]

{ #category : #'presenter building' }
ChestTableWithContentPresenter >> makeConfirmActionBar [

	confirmButton := self newButton
		                 label: 'Confirm';
		                 yourself.

	cancelButton := self newButton
		                label: 'Cancel';
		                action: [ self window close ];
		                yourself.

	^ self newActionBar
		  add: confirmButton;
		  add: cancelButton;
		  yourself
]

{ #category : #'presenter building' }
ChestTableWithContentPresenter >> makeInputField [

	^ self newTextInput
		  placeholder: 'Choose a name for your object';
		  text: (chestsTable selectedItem
				   ifNotNil: [ :selectedChest | 
					   selectedChest nextDefaultNameForObject ]
				   ifNil: [ '' ]);
		  yourself
]

{ #category : #layout }
ChestTableWithContentPresenter >> storeCommandLayout [

	self chestTableContainer
		removeAll;
		add: inputField;
		add: #chestsTable.
	self chestContentTableContainer
		removeAll;
		add: #chestContentsTable.

	^ SpBoxLayout newVertical
		  add: self defaultLayout;
		  add: #confirmActionBar;
		  yourself
]

{ #category : #updating }
ChestTableWithContentPresenter >> subscribeToChestAnnouncer [

	self
		subscribeToChestCreatedAnnouncement;
		subscribeToChestUpdatedAnnouncement;
		subscribeToChestRemovedAnnouncement
]

{ #category : #subscription }
ChestTableWithContentPresenter >> subscribeToChestCreatedAnnouncement [

	Chest announcer weak
		when: ChestCreated
		send: #eventNewChest:
		to: self
]

{ #category : #subscription }
ChestTableWithContentPresenter >> subscribeToChestRemovedAnnouncement [

	Chest announcer weak
		when: ChestRemoved
		send: #eventChestRemoved:
		to: self
]

{ #category : #subscription }
ChestTableWithContentPresenter >> subscribeToChestUpdatedAnnouncement [

	Chest announcer weak
		when: ChestUpdated
		send: #eventContentOfChestUpdated:
		to: self
]

{ #category : #accessing }
ChestTableWithContentPresenter >> title [

	^ 'Choose a variable name for your object'
]

{ #category : #subscription }
ChestTableWithContentPresenter >> unsubscribeFromChestAnnouncer [

	Chest unsubscribe: self
]

{ #category : #update }
ChestTableWithContentPresenter >> updateChestContentTableForChest: aChest [

	chestContentsTable ifNotNil: [ :lst | 
		lst items: aChest contents associations asOrderedCollection ]
]

{ #category : #updating }
ChestTableWithContentPresenter >> updateChestsTable [

	chestsTable ifNotNil: [ :lst | lst items: Chest allChests ]
]

{ #category : #'ui - dialogs' }
ChestTableWithContentPresenter >> warningNamingObjectInChest: newObjectName [

	^ '`' , newObjectName
	  ,
	  '` is the name of an object that already exists in this chest. If you proceed, this object in the existing chest will be removed and lost. Are you sure you want to proceed?'
]
