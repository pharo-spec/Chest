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
		'chestTableContainer',
		'chestContentTableContainer',
		'chestsTableToolbar',
		'chestContentsTableToolbar'
	],
	#category : #Chest
}

{ #category : #commands }
ChestTableWithContentPresenter class >> buildChestContentTableMenuGroupWith: aChestWithContentPresenter forRoot: aRoot [

	| group |
	group := (CmCommandGroup named: 'ChestContentMenu') asSpecGroup.
	self
		registerClasses: ChestCommand chestTableContentMenuCommandClasses
		toGroup: group.
		
	group displayMode: CmUIHideWhenCantBeRun.

	aRoot register: group
]

{ #category : #commands }
ChestTableWithContentPresenter class >> buildChestContentTableToolbarGroupWith: aChestWithContentPresenter forRoot: aRoot [

	| group |
	group := (CmCommandGroup named: 'ChestContentToolbar') asSpecGroup.
	self
		registerClasses: ChestCommand chestTableContentToolbarCommandClasses
		toGroup: group.
		
	group displayMode: CmUIHideWhenCantBeRun.

	aRoot register: group
]

{ #category : #commands }
ChestTableWithContentPresenter class >> buildChestTableMenuGroupWith: aChestWithContentPresenter forRoot: aRoot [

	| group |
	group := (CmCommandGroup named: 'ChestMenu') asSpecGroup.
	self
		registerClasses: ChestCommand chestTableMenuCommandClasses
		toGroup: group.
		
	group displayMode: CmUIHideWhenCantBeRun.

	aRoot register: group
]

{ #category : #commands }
ChestTableWithContentPresenter class >> buildChestTableToolbarGroupWith: aChestWithContentPresenter forRoot: aRoot [

	| group |
	group := (CmCommandGroup named: 'ChestToolbar') asSpecGroup.
	self
		registerClasses: ChestCommand chestTableToolbarCommandClasses
		toGroup: group.
		
	group displayMode: CmUIHideWhenCantBeRun.

	aRoot register: group
]

{ #category : #commands }
ChestTableWithContentPresenter class >> buildCommandsGroupWith: aChestWithTablePresenter forRoot: aCmCommandGroup [

	self
		buildChestTableMenuGroupWith: aChestWithTablePresenter
		forRoot: aCmCommandGroup.
	self
		buildChestContentTableMenuGroupWith: aChestWithTablePresenter
		forRoot: aCmCommandGroup.
	self
		buildTreeTableMenuGroupWith: aChestWithTablePresenter
		forRoot: aCmCommandGroup.
	self
		buildTreeTableToolbarGroupWith: aChestWithTablePresenter
		forRoot: aCmCommandGroup.
	self
		buildChestTableToolbarGroupWith: aChestWithTablePresenter
		forRoot: aCmCommandGroup.
	self
		buildChestContentTableToolbarGroupWith: aChestWithTablePresenter
		forRoot: aCmCommandGroup
]

{ #category : #commands }
ChestTableWithContentPresenter class >> buildTreeTableMenuGroupWith: aChestWithContentPresenter forRoot: aRoot [

	| group |
	group := (CmCommandGroup named: 'ChestWithContentMenu') asSpecGroup.
	self
		registerClasses: ChestCommand chestTreeTableMenuCommandClasses
		toGroup: group.
		
	group displayMode: CmUIHideWhenCantBeRun.

	aRoot register: group
]

{ #category : #commands }
ChestTableWithContentPresenter class >> buildTreeTableToolbarGroupWith: aChestWithContentPresenter forRoot: aRoot [

	| group |
	group := (CmCommandGroup named: 'ChestWithContentToolbar') asSpecGroup.
	self
		registerClasses: ChestCommand chestTreeTableToolbarCommandClasses
		toGroup: group.
		
	group displayMode: CmUIHideWhenCantBeRun.

	aRoot register: group
]

{ #category : #commands }
ChestTableWithContentPresenter class >> registerClasses: commandClasses toGroup: aGroup [

	commandClasses do: [ :aClass | aGroup register: aClass ]
]

{ #category : #accessing }
ChestTableWithContentPresenter >> cancelButton [

	^ self confirmActionBar presenters last
]

{ #category : #updating }
ChestTableWithContentPresenter >> chestContentTable [

	^ chestContentsTable
]

{ #category : #'as yet unclassified' }
ChestTableWithContentPresenter >> chestContentTableContainer [

	^ chestContentTableContainer
]

{ #category : #accessing }
ChestTableWithContentPresenter >> chestContentsTableToolbar [

	^ chestContentsTableToolbar
]

{ #category : #'as yet unclassified' }
ChestTableWithContentPresenter >> chestTableContainer [

	^ chestTableContainer
]

{ #category : #updating }
ChestTableWithContentPresenter >> chestsTable [

	^ chestsTable
]

{ #category : #accessing }
ChestTableWithContentPresenter >> chestsTableToolbar [

	^ chestsTableToolbar
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

	^ self confirmActionBar presenters first
]

{ #category : #initialization }
ChestTableWithContentPresenter >> connectPresenters [

	chestsTable
		transmitDo: [ :aChest | 
			aChest
				ifNotNil: [ 
					self updateChestContentTableForChest: aChest.
					chestContentsTable items ifNotEmpty: [ 
							chestContentsTable selectIndex: 1 ].
					inputField text: aChest nextDefaultNameForObject ]
				ifNil: [ 
					chestContentsTable items: {  } asOrderedCollection.
					inputField text: '' ] ];
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

{ #category : #initialization }
ChestTableWithContentPresenter >> iconManager [

	^ Smalltalk ui icons
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

	chestsTableToolbar := self makeChestsTableToolbar.
	chestContentsTableToolbar := self makeChestContentsTableToolbar.

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

{ #category : #'as yet unclassified' }
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

{ #category : #initialization }
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

{ #category : #initialization }
ChestTableWithContentPresenter >> makeChestContentsTableToolbar [

	| toolbar |
	toolbar := self newToolbar.
	^ toolbar
]

{ #category : #initialization }
ChestTableWithContentPresenter >> makeChestsTable [

	^ self newList
		  items: Chest allChests;
		  display: [ :chest | chest name ];
		  
		  sortingBlock: [ :chest1 :chest2 | chest1 name < chest2 name ];
		  yourself
]

{ #category : #initialization }
ChestTableWithContentPresenter >> makeChestsTableToolbar [

	| toolbar |
	toolbar := self newToolbar.
	toolbar addItem: (self newToolbarButton
			 label: 'add';
			 icon: (self iconManager iconNamed: #add);
			 action: [ self requestNameNewChest ]).
	^ toolbar
]

{ #category : #'as yet unclassified' }
ChestTableWithContentPresenter >> makeConfirmActionBar [

	^ self newActionBar
		  add: (self newButton
				   label: 'Confirm';
				   yourself);
		  add: (self newButton
				   label: 'Cancel';
				   action: [ self window close ];
				   yourself);
		  yourself
]

{ #category : #'as yet unclassified' }
ChestTableWithContentPresenter >> makeInputField [

	^ self newTextInput
		  placeholder: 'Choose a name for your object';
		  text: (chestsTable selectedItem
				   ifNotNil: [ :selectedChest | 
					   selectedChest nextDefaultNameForObject ]
				   ifNil: [ '' ]);
		  yourself
]

{ #category : #'ui - requests' }
ChestTableWithContentPresenter >> namingQuery [

	^ 'What name do you want to give to your object?'
]

{ #category : #'presenter building' }
ChestTableWithContentPresenter >> presenterToNameNewChest [

	^ ChestRequestDialogPresenter
		  request: self namingQuery
		  onAccept: [ :newChestName | 
			  [ Chest newNamed: newChestName ]
				  on: ChestKeyAlreadyInUseError
				  do: [ 
					  | chest |
					  chest := Chest named: newChestName.
					  ((self confirm: (self warningNamingChest: newChestName)) and: [ 
						   chest ~= Chest defaultInstance ])
						  ifTrue: [ 
							  chest remove.
							  Chest newNamed: newChestName ]
						  ifFalse: [ 
						  UIManager default inform:
							  newChestName , ' could not be removed.' ] ] ]
]

{ #category : #'ui - dialogs' }
ChestTableWithContentPresenter >> requestNameNewChest [

	| requestPresenter |
	requestPresenter := self presenterToNameNewChest.
	(self newPopover
		 presenter: requestPresenter;
		 relativeTo: chestsTableToolbar;
		 bePositionRight;
		 yourself) popup
]

{ #category : #'as yet unclassified' }
ChestTableWithContentPresenter >> storeCommandLayout [

	self chestTableContainer
		removeAll;
		add: inputField;
		add: #chestsTable;
		add: chestsTableToolbar.
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

{ #category : #'as yet unclassified' }
ChestTableWithContentPresenter >> subscribeToChestCreatedAnnouncement [

	Chest announcer weak
		when: ChestCreated
		send: #eventNewChest:
		to: self
]

{ #category : #'as yet unclassified' }
ChestTableWithContentPresenter >> subscribeToChestRemovedAnnouncement [

	Chest announcer weak
		when: ChestRemoved
		send: #eventChestRemoved:
		to: self
]

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
ChestTableWithContentPresenter >> unsubscribeFromChestAnnouncer [

	Chest unsubscribe: self
]

{ #category : #initialization }
ChestTableWithContentPresenter >> updateChestContentTableForChest: aChest [

	chestContentsTable ifNotNil: [ :lst | 
		lst items: aChest contents associations asOrderedCollection ]
]

{ #category : #updating }
ChestTableWithContentPresenter >> updateChestsTable [

	chestsTable ifNotNil: [ :lst | lst items: Chest allChests ]
]

{ #category : #'ui - requests' }
ChestTableWithContentPresenter >> warningNamingChest: newChestName [

	^ '`' , newChestName
	  ,
	  '` is the name of a chest that already exists. If you proceed, all objects in the existing chest will be lost. Are you sure you want to proceed?'
]

{ #category : #'as yet unclassified' }
ChestTableWithContentPresenter >> warningNamingObjectInChest: newObjectName [

	^ '`' , newObjectName
	  ,
	  '` is the name of an object that already exists in this chest. If you proceed, this object in the existing chest will be removed and lost. Are you sure you want to proceed?'
]
