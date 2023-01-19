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
		'chestContentsTableToolbar',
		'chestWithContentTreeTable',
		'chestTableWithContentContainer',
		'activePresenter',
		'chestWithContentTreeTableToolbar'
	],
	#category : #Chest
}

{ #category : #commands }
ChestTableWithContentPresenter class >> buildChestContentTableMenuGroupWith: aChestWithContentPresenter forRoot: aRoot [

	| group |
	group := (CmCommandGroup named: self chestContentMenuGroupName)
		         asSpecGroup
		         beDisplayedAsGroup;
		         yourself.
	self
		registerClasses: ChestCommand chestTableContentMenuCommandClasses
		toGroup: group
		withContext: aChestWithContentPresenter.

	aRoot register: group
]

{ #category : #commands }
ChestTableWithContentPresenter class >> buildChestContentTableToolbarGroupWith: aChestWithContentPresenter forRoot: aRoot [

	| group |
	group := (CmCommandGroup named: self chestContentToolbarGroupName)
		         asSpecGroup.
	self
		registerClasses: ChestCommand chestTableContentToolbarCommandClasses
		toGroup: group
		withContext: aChestWithContentPresenter.

	aRoot register: group
]

{ #category : #commands }
ChestTableWithContentPresenter class >> buildChestTableMenuGroupWith: aChestWithContentPresenter forRoot: aRoot [

	| group |
	group := (CmCommandGroup named: self chestMenuGroupName) asSpecGroup
		         beDisplayedAsGroup;
		         yourself.
	self
		registerClasses: ChestCommand chestTableMenuCommandClasses
		toGroup: group
		withContext: aChestWithContentPresenter.

	aRoot register: group
]

{ #category : #commands }
ChestTableWithContentPresenter class >> buildChestTableToolbarGroupWith: aChestWithContentPresenter forRoot: aRoot [

	| group |
	group := (CmCommandGroup named: self chestToolbarGroupName)
		         asSpecGroup.
	self
		registerClasses: ChestCommand chestTableToolbarCommandClasses
		toGroup: group
		withContext: aChestWithContentPresenter.

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
	group := (CmCommandGroup named: self chestWithContentMenuGroupName)
		         asSpecGroup
		         beDisplayedAsGroup;
		         yourself.
	self
		registerClasses: ChestCommand chestTreeTableMenuCommandClasses
		toGroup: group
		withContext: aChestWithContentPresenter.

	aRoot register: group
]

{ #category : #commands }
ChestTableWithContentPresenter class >> buildTreeTableToolbarGroupWith: aChestWithContentPresenter forRoot: aRoot [

	| group |
	group := (CmCommandGroup named: self chestWithContentToolbarGroupName)
		         asSpecGroup.
	self
		registerClasses: ChestCommand chestTreeTableToolbarCommandClasses
		toGroup: group
		withContext: aChestWithContentPresenter.

	aRoot register: group
]

{ #category : #commands }
ChestTableWithContentPresenter class >> chestContentMenuGroupName [

	^ 'ChestContentMenu'
]

{ #category : #commands }
ChestTableWithContentPresenter class >> chestContentToolbarGroupName [

	^ 'ChestContentToolbar'
]

{ #category : #commands }
ChestTableWithContentPresenter class >> chestMenuGroupName [

	^ 'ChestMenu'
]

{ #category : #commands }
ChestTableWithContentPresenter class >> chestToolbarGroupName [

	^ 'ChestToolbar'
]

{ #category : #commands }
ChestTableWithContentPresenter class >> chestWithContentMenuGroupName [

	^ 'ChestWithContentMenu'
]

{ #category : #commands }
ChestTableWithContentPresenter class >> chestWithContentToolbarGroupName [

	^ 'ChestWithContentToolbar'
]

{ #category : #commands }
ChestTableWithContentPresenter class >> registerClasses: commandClasses toGroup: aGroup withContext: aChestWithContentPresenter [

	commandClasses do: [ :aClass | 
		aGroup register: ((aClass
				  forSpecWithIconNamed: aClass defaultIconName
				  shortcutKey: aClass defaultShortcutKey)
				 context: aChestWithContentPresenter;
				 beHiddenWhenCantBeRun) ]
]

{ #category : #accessing }
ChestTableWithContentPresenter >> activePresenter [

	^ activePresenter
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

{ #category : #accessing }
ChestTableWithContentPresenter >> chestTableWithContentContainer [

	^ chestTableWithContentContainer
]

{ #category : #initialization }
ChestTableWithContentPresenter >> chestWithContentTreeTable [

	^ chestWithContentTreeTable
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

{ #category : #layout }
ChestTableWithContentPresenter >> debuggerLayout [

	activePresenter := self chestWithContentTreeTable.

	^ SpBoxLayout newVertical
		  add: chestWithContentTreeTableToolbar expand: false;
		  add: chestWithContentTreeTable;
		  yourself
]

{ #category : #updating }
ChestTableWithContentPresenter >> defaultLayout [

	self makeChestContentsTable.

	chestTableContainer
		removeAll;
		add: (self
				 headerLayoutWithTitle: 'Chests'
				 withToolbar: self chestsTableToolbar)
		withConstraints: [ :cstr | cstr height: 35 ];
		add: chestsTable.

	chestContentTableContainer
		removeAll;
		add: (self
				 headerLayoutWithTitle: 'Contents'
				 withToolbar: self chestContentsTableToolbar)
		withConstraints: [ :cstr | cstr height: 35 ];
		add: chestContentsTable.
		
	activePresenter := chestTableWithContentContainer.

	^ chestTableWithContentContainer
]

{ #category : #updating }
ChestTableWithContentPresenter >> eventChestRemoved: aChestRemovedAnnouncement [

	self updateChestsTable
]

{ #category : #updating }
ChestTableWithContentPresenter >> eventContentOfChestUpdated: aChestUpdatedAnnouncement [

	| currentlySelectedChest updatedChest |
	self flag: 'to do with polymorphism'.
	
	updatedChest := aChestUpdatedAnnouncement updatedChest.
	currentlySelectedChest := self selectedChest.
	activePresenter == chestWithContentTreeTable ifTrue: [ 
		self updateChestContentTableForChest: updatedChest ].

	currentlySelectedChest == updatedChest ifTrue: [ 
		self updateChestContentTableForChest: updatedChest ]
]

{ #category : #updating }
ChestTableWithContentPresenter >> eventNewChest: aChestCreatedAnnouncement [

	self updateChestsTable
]

{ #category : #layout }
ChestTableWithContentPresenter >> headerLayoutWithTitle: aString withToolbar: aToolbar [

	^ SpBoxLayout newHorizontal
		  add: (SpLabelPresenter new
				   label: aString;
				   yourself)
		  expand: false;
		  addLast: aToolbar expand: false;
		  yourself
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

	self makeChestsTable.
	chestTableContainer := SpBoxLayout newVertical
		                       add: self chestsTable;
		                       yourself.
	self makeChestContentsTable.
	chestContentTableContainer := SpBoxLayout newVertical
		                              add: self chestContentTable;
		                              yourself.
	chestsTable selectIndex: 1.
	chestTableWithContentContainer := SpPanedLayout newHorizontal
		                                  add: chestTableContainer;
		                                  add: chestContentTableContainer;
		                                  yourself.
	activePresenter := chestTableWithContentContainer.
	inputField := self makeInputField.
	confirmActionBar := self makeConfirmActionBar.

	self makeChestWithContentTreeTable.

	chestsTableToolbar := self makeChestsTableToolbar.
	chestContentsTableToolbar := self makeChestContentsTableToolbar.

	chestWithContentTreeTableToolbar := self makeChestTreeTableToolbar.

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

	| inputVariableNameColumn |
	inputVariableNameColumn := (SpStringTableColumn
		                            title: 'Variable Name'
		                            evaluated: #variableName)
		                           beEditable;
		                           onAcceptEdition: [ :assoc :newVarName | 
			                           assoc variableName: newVarName ];
		                           yourself.
	self makeChestContentsTable.
	chestContentsTable
		beMultipleSelection;
		addColumn: inputVariableNameColumn.

	self chestTableContainer
		removeAll;
		add: chestsTable.
	self chestContentTableContainer
		removeAll;
		add: chestContentsTable.

	^ SpBoxLayout newVertical
		  add: chestTableWithContentContainer;
		  add: (SpBoxLayout newHorizontal
				   add: chestsTableToolbar;
				   add: chestContentsTableToolbar;
				   yourself);
		  add: confirmActionBar;
		  yourself
]

{ #category : #initialization }
ChestTableWithContentPresenter >> makeChestContentTableContextMenu [

	chestContentsTable contextMenu: [ 
		(self rootCommandsGroup / self class chestContentMenuGroupName)
			asMenuPresenter ].

	chestContentsTable applyKeyBindingsFromMenu:
		chestContentsTable contextMenu value
]

{ #category : #initialization }
ChestTableWithContentPresenter >> makeChestContentsTable [

	chestContentsTable := self newTable
		                      addColumn: ((SpStringTableColumn
				                        title: 'Name'
				                        evaluated: [ :association | 
					                        association key ]) width: 40);
		                      addColumn: (SpStringTableColumn
				                       title: 'Object'
				                       evaluated: [ :association | 
					                       association value asString ]);
		                      items: #(  ) asOrderedCollection.
	self makeChestContentTableContextMenu
]

{ #category : #initialization }
ChestTableWithContentPresenter >> makeChestContentsTableToolbar [

	| toolbar |
	toolbar := self newToolbar.
	^ toolbar
		  displayMode: StPharoSettings toolbarDisplayMode;
		  addStyle: 'stToolbar';
		  fillWith:
			  self rootCommandsGroup / self class chestContentToolbarGroupName;
		  yourself
]

{ #category : #initialization }
ChestTableWithContentPresenter >> makeChestTableContextMenu [

	chestsTable contextMenu: [ 
		(self rootCommandsGroup / self class chestMenuGroupName)
			asMenuPresenter ].

	chestsTable applyKeyBindingsFromMenu: chestsTable contextMenu value
]

{ #category : #initialization }
ChestTableWithContentPresenter >> makeChestTreeTableContextMenu [

	chestWithContentTreeTable contextMenu: [ 
		(self rootCommandsGroup / self class chestWithContentMenuGroupName)
			asMenuPresenter ].

	chestWithContentTreeTable applyKeyBindingsFromMenu:
		chestWithContentTreeTable contextMenu value
]

{ #category : #initialization }
ChestTableWithContentPresenter >> makeChestTreeTableToolbar [

	| toolbar |
	toolbar := self newToolbar.
	^ toolbar
		  displayMode: StPharoSettings toolbarDisplayMode;
		  addStyle: 'stToolbar';
		  fillWith:
			  self rootCommandsGroup / self class chestWithContentToolbarGroupName;
		  yourself
]

{ #category : #initialization }
ChestTableWithContentPresenter >> makeChestWithContentTreeTable [

	| treeTable |
	treeTable := SpTreeTablePresenter new.
	treeTable
		roots: Chest allChests;
		children: [ :anObject | anObject chestChildren ].

	chestWithContentTreeTable := treeTable
		                             addColumn: (SpCompositeTableColumn new
				                              title: 'Chests';
				                              addColumn:
					                              ((SpImageTableColumn evaluated: [ 
							                                :anObject | 
							                                anObject class chestIcon ])
						                               width: 20;
						                               yourself);
				                              addColumn:
					                              (SpStringTableColumn evaluated: [ 
						                               :anObject | 
						                               anObject chestEvaluation ])
						                              yourself);
		                             addColumn:
			                             ((SpStringTableColumn new title:
					                               'Name')
				                              evaluated: [ :anObject | 
					                              anObject chestName ];
				                              yourself);
		                             beResizable;
		                             activatesOnDoubleClick;
		                             whenActivatedDo: [ :selection | 
		                             selection selectedItem inspect ];
		                             yourself.
	self makeChestTreeTableContextMenu
]

{ #category : #initialization }
ChestTableWithContentPresenter >> makeChestsTable [

	chestsTable := self newList
		               items: Chest allChests;
		               display: [ :chest | chest name ];
		               sortingBlock: [ :chest1 :chest2 | 
			               chest1 name < chest2 name ];
		               yourself.
	self makeChestTableContextMenu
]

{ #category : #initialization }
ChestTableWithContentPresenter >> makeChestsTableToolbar [

	| toolbar |
	toolbar := self newToolbar.
	^ toolbar
		  displayMode: StPharoSettings toolbarDisplayMode;
		  addStyle: 'stToolbar';
		  fillWith:
			  self rootCommandsGroup / self class chestToolbarGroupName;
		  yourself
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
		  text: (self selectedChest
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
			  [ 
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
				  on: ChestInvalidNameError
				  do: [ 
				  UIManager inform:
					  newChestName , ' is not a valid name for a chest.' ] ]
]

{ #category : #'presenter building' }
ChestTableWithContentPresenter >> presenterToRenameChest: chest [

	^ ChestRequestDialogPresenter
		  request: self namingQuery
		  onAccept: [ :newChestName | 
			  [ 
			  [ chest name: newChestName ]
				  on: ChestKeyAlreadyInUseError
				  do: [
					  | chestBlockingRenaming |
					  chestBlockingRenaming := Chest named: newChestName.
					  ((self confirm: (self warningNamingChest: newChestName)) and: [ 
						   chestBlockingRenaming ~= Chest defaultInstance ])
						  ifTrue: [ 
							  chestBlockingRenaming remove.
							  chest name: newChestName ]
						  ifFalse: [ 
						  UIManager default inform:
							  newChestName , ' could not be removed.' ] ] ]
				  on: ChestInvalidNameError
				  do: [ 
					  UIManager inform:
						  newChestName
						  , ' is not a valid name for a chest.' ] ]
]

{ #category : #'presenter building' }
ChestTableWithContentPresenter >> presenterToRenameObject: object inChest: chest [

	^ ChestRequestDialogPresenter
		  request: self namingQuery
		  onAccept: [ :name | 
			  [ 
			  [ chest renameObject: object into: name ]
				  on: ChestKeyAlreadyInUseError
				  do: [ 
					  (self confirm: (self warningNamingObjectInChest: name)) 
						  ifTrue: [ 
							  chest removeObjectNamed: name.
							  chest renameObject: object into: name ] ] ]
				  on: ChestInvalidNameError
				  do: [ 
					  UIManager inform:
						  name , ' is not a valid name an object.' ] ]
]

{ #category : #removing }
ChestTableWithContentPresenter >> removeAllChests [

	| items |
	self flag: 'to do with polymorphism'.

	items := activePresenter == chestWithContentTreeTable
		         ifTrue: [ chestWithContentTreeTable roots ]
		         ifFalse: [ chestsTable items ].
	items copy do: [ :chest | chest remove ]
]

{ #category : #removing }
ChestTableWithContentPresenter >> removeAllItemsFromSelectedChest [

	| items |
	self flag: 'to do with polymorphism'.

	items := activePresenter == chestWithContentTreeTable
		         ifTrue: [ 
		         chestWithContentTreeTable childrenFor: self selectedChest ]
		         ifFalse: [ chestContentsTable items ].
	items do: [ :assoc | self selectedChest remove: assoc value ]
]

{ #category : #removing }
ChestTableWithContentPresenter >> removeSelectedChest [

	| selectedChestIndex |
	self flag: 'to do with polymorphism'.
	
	self selectedChest remove.
	activePresenter == chestWithContentTreeTable ifTrue: [ ^ self ].
	chestsTable selectIndex:
		(1 max: chestsTable selection selectedIndex - 1)
		
	"activePresenter == chestWithContentTreeTable ifTrue: [ ^ self ]."
]

{ #category : #removing }
ChestTableWithContentPresenter >> removeSelectedItem [

	| assoc |
	self flag: 'to do with polymorphism'.
	
	assoc := self selectedItem.
	self selectedChest remove: assoc value.
	activePresenter == chestWithContentTreeTable ifTrue: [ ^ self ].
	(chestContentsTable selection selectedIndex = 1 and: [ 
		 chestContentsTable items isNotEmpty ])
		ifTrue: [ chestContentsTable selectIndex: 1 ]
		ifFalse: [ 
			chestContentsTable selectIndex:
				chestContentsTable selection selectedIndex - 1 ]
]

{ #category : #renaming }
ChestTableWithContentPresenter >> renameSelectedChest [

	self flag: 'to do with polymorphism'.

	self
		requestRenameChest: self selectedChest
		fromContextMenuItem: (activePresenter == chestWithContentTreeTable
				 ifTrue: [ chestWithContentTreeTable ]
				 ifFalse: [ chestsTable ])
]

{ #category : #renaming }
ChestTableWithContentPresenter >> renameSelectedItem [

	"need to redo renaming and removing + event handlers to take into account tree table (+ add load commands in ChestPresenter for treeTable menu)"

	self flag: 'to do with polymorphism'.

	^ self
		  requestRenameObjectFromChest: self selectedItem
		  fromContextMenuItem:
			  (activePresenter == chestWithContentTreeTable
				   ifTrue: [ chestWithContentTreeTable ]
				   ifFalse: [ chestContentsTable ])
]

{ #category : #'ui - dialogs' }
ChestTableWithContentPresenter >> requestNameNewChest [

	| requestPresenter |
	requestPresenter := self presenterToNameNewChest.
	(self newPopover
		 presenter: requestPresenter;
		 relativeTo: activePresenter;
		 bePositionRight;
		 yourself) popup
]

{ #category : #'ui - dialogs' }
ChestTableWithContentPresenter >> requestRenameChest: chest fromContextMenuItem: anItem [

	| requestPresenter |
	requestPresenter := self presenterToRenameChest: chest.
	(self newPopover
		 presenter: requestPresenter;
		 relativeTo: anItem;
		 bePositionRight;
		 yourself) popup
]

{ #category : #'ui - dialogs' }
ChestTableWithContentPresenter >> requestRenameObjectFromChest: objectNameValueAssociation fromContextMenuItem: anItem [

	| chest requestPresenter object |
	object := objectNameValueAssociation value.
	chest := activePresenter == chestWithContentTreeTable
		         ifTrue: [ 
			         chestWithContentTreeTable roots detect: [ :root | 
				         (chestWithContentTreeTable childrenFor: root) 
					         identityIncludes: objectNameValueAssociation ] ]
		         ifFalse: [ self selectedChest ].
	requestPresenter := self
		                    presenterToRenameObject: object
		                    inChest: chest.
	(self newPopover
		 presenter: requestPresenter;
		 relativeTo: anItem;
		 bePositionRight;
		 yourself) popup
]

{ #category : #accessing }
ChestTableWithContentPresenter >> selectedChest [

	self flag: 'to do with polymorphism'.

	(activePresenter isNotNil and: [ 
		 activePresenter == chestWithContentTreeTable ]) ifTrue: [ 
		^ chestWithContentTreeTable selectedItem isChest
			  ifTrue: [ chestWithContentTreeTable selectedItem ]
			  ifFalse: [ nil ] ].
	^ chestsTable selection selectedItem
]

{ #category : #accessing }
ChestTableWithContentPresenter >> selectedItem [

	self flag: 'to do with polymorphism'.

	(activePresenter isNotNil and: [ 
		 activePresenter == chestWithContentTreeTable ]) ifTrue: [ 
		^ chestWithContentTreeTable selectedItem isChest
			  ifFalse: [ chestWithContentTreeTable selectedItem ]
			  ifTrue: [ nil ] ].
	^ chestContentsTable selection selectedItem

	"^ activePresenter selectedChestItem"
]

{ #category : #'as yet unclassified' }
ChestTableWithContentPresenter >> storeCommandLayout [

	self makeChestContentsTable.

	self chestTableContainer
		removeAll;
		add: inputField;
		add: chestsTable.
	self chestContentTableContainer
		removeAll;
		add: chestContentsTable.

	^ SpBoxLayout newVertical
		  add: chestTableWithContentContainer;
		  add: (SpBoxLayout newHorizontal
				   add: chestsTableToolbar;
				   add: chestContentsTableToolbar;
				   yourself);
		  add: confirmActionBar;
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

	self flag: 'to do with polymorphism'.

	activePresenter == chestWithContentTreeTable ifTrue: [ 
		chestWithContentTreeTable roots: Chest allChests.
		^ self ].
	chestContentsTable ifNotNil: [ :lst | 
		lst items: aChest contents associations asOrderedCollection ]
]

{ #category : #updating }
ChestTableWithContentPresenter >> updateChestsTable [

	self flag: 'to do with polymorphism'.

	activePresenter == chestWithContentTreeTable ifTrue: [ 
		chestWithContentTreeTable roots: Chest allChests.
		^ self ].
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
