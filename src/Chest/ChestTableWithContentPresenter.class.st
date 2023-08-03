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
		'chestContentTableContainer',
		'chestsTableToolbar',
		'chestContentsTableToolbar',
		'chestWithContentTreeTable',
		'chestTableWithContentContainer',
		'activePresenter',
		'chestWithContentTreeTableToolbar',
		'chestTableToolbarCommandGroup',
		'chestContentsTableToolbarCommandGroup',
		'buttonNoCopy',
		'buttonShallowCopy',
		'buttonDeepCopy'
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
ChestTableWithContentPresenter >> buttonDeepCopy [

	^ buttonDeepCopy
]

{ #category : #accessing }
ChestTableWithContentPresenter >> buttonNoCopy [

	^ buttonNoCopy
]

{ #category : #accessing }
ChestTableWithContentPresenter >> buttonShallowCopy [

	^ buttonShallowCopy
]

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
ChestTableWithContentPresenter >> chestContentsTableToolbar [

	^ chestContentsTableToolbar
]

{ #category : #initialization }
ChestTableWithContentPresenter >> chestContentsTableTransmitBlock [

	^ [ :selection | self updateChestContentToolbar ]
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
			  inputField text: '' ].

	  self updateChestToolbar ]
]

{ #category : #accessing }
ChestTableWithContentPresenter >> chestTableWithContentContainer [

	^ chestTableWithContentContainer
]

{ #category : #accessing }
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

	^ confirmButton
]

{ #category : #initialization }
ChestTableWithContentPresenter >> connectPresenters [

	chestsTable
		transmitDo: self chestTableTransmitBlock;
		selectFirst.

	chestContentsTable transmitDo: self chestContentsTableTransmitBlock
]

{ #category : #layout }
ChestTableWithContentPresenter >> debuggerLayout [

	activePresenter := self chestWithContentTreeTable.

	^ SpBoxLayout newVertical
		  add: chestWithContentTreeTableToolbar expand: false;
		  add: chestWithContentTreeTable;
		  yourself
]

{ #category : #layout }
ChestTableWithContentPresenter >> defaultLayout [

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

{ #category : #initialization }
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
	
	self makeCopyRadioButtons.

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
				   yourself)
		  expand: false;
		  add: confirmActionBar expand: false;
		  yourself
]

{ #category : #'presenter building' }
ChestTableWithContentPresenter >> makeChestContentTableContextMenu [

	chestContentsTable contextMenu: [ 
		(self rootCommandsGroup / self class chestContentMenuGroupName)
			asMenuPresenter ].

	chestContentsTable applyKeyBindingsFromMenu:
		chestContentsTable contextMenu value
]

{ #category : #'presenter building' }
ChestTableWithContentPresenter >> makeChestContentsTable [

	chestContentsTable := self newTable
		                      addColumn: (SpStringTableColumn
				                       title: 'Name'
				                       evaluated: [ :association |
					                       association key ]) beExpandable;
		                      addColumn: (SpStringTableColumn
				                       title: 'Value'
				                       evaluated: [ :association |
					                       association value printString ])
				                      beExpandable;
		                      addColumn: (SpStringTableColumn
				                       title: 'Class'
				                       evaluated: [ :association |
					                       association value class name ])
				                      beExpandable;
		                      items: #(  ) asOrderedCollection;
		                      beResizable;
		                      yourself.
	self makeChestContentTableContextMenu
]

{ #category : #'presenter building' }
ChestTableWithContentPresenter >> makeChestContentsTableToolbar [

	| toolbar |
	toolbar := self newToolbar.
	^ toolbar
		  displayMode: StPharoSettings toolbarDisplayMode;
		  addStyle: 'stToolbar';
		  fillWith:
			  (chestContentsTableToolbarCommandGroup := self rootCommandsGroup
			                                            /
				                                            self class
					                                            chestContentToolbarGroupName);
		  yourself
]

{ #category : #'presenter building' }
ChestTableWithContentPresenter >> makeChestTableContextMenu [

	chestsTable contextMenu: [ 
		(self rootCommandsGroup / self class chestMenuGroupName)
			asMenuPresenter ].

	chestsTable applyKeyBindingsFromMenu: chestsTable contextMenu value
]

{ #category : #'presenter building' }
ChestTableWithContentPresenter >> makeChestTreeTableContextMenu [

	chestWithContentTreeTable contextMenu: [ 
		(self rootCommandsGroup / self class chestWithContentMenuGroupName)
			asMenuPresenter ].

	chestWithContentTreeTable applyKeyBindingsFromMenu:
		chestWithContentTreeTable contextMenu value
]

{ #category : #'presenter building' }
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

{ #category : #'presenter building' }
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
		                             isActiveOnDoubleClick;
		                             whenActivatedDo: [ :selection |
		                             selection selectedItem inspect ];
		                             yourself.
	self makeChestTreeTableContextMenu
]

{ #category : #'presenter building' }
ChestTableWithContentPresenter >> makeChestsTable [

	chestsTable := self newTable
		               items: Chest allChests;
		               addColumn:
			               (SpStringTableColumn
				                title: 'Name'
				                evaluated: [ :chest | chest name ]) beExpandable;
		               addColumn: ((SpStringTableColumn
				                 title: 'Size'
				                 evaluated: [ :chest |
					                 chest contents size asString ]) width: 40);
		               sortingBlock: [ :chest1 :chest2 |
			               chest1 name < chest2 name ];
		               beResizable;
		               yourself.
	self makeChestTableContextMenu
]

{ #category : #'presenter building' }
ChestTableWithContentPresenter >> makeChestsTableToolbar [

	| toolbar |
	toolbar := self newToolbar.
	^ toolbar
		  displayMode: StPharoSettings toolbarDisplayMode;
		  addStyle: 'stToolbar';
		  fillWith:
			  (chestTableToolbarCommandGroup := self rootCommandsGroup
			                                    /
				                                    self class
					                                    chestToolbarGroupName);
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
ChestTableWithContentPresenter >> makeCopyRadioButtons [

	buttonNoCopy := self newRadioButton.
	buttonShallowCopy := self newRadioButton.
	buttonDeepCopy := self newRadioButton.

	buttonNoCopy associatedRadioButtons: {
			buttonShallowCopy.
			buttonDeepCopy }.

	buttonNoCopy label: 'No copy'.
	buttonShallowCopy label: 'Shallow copy'.
	buttonDeepCopy label: 'Deep copy'
]

{ #category : #'presenter building' }
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

{ #category : #'ui - requests' }
ChestTableWithContentPresenter >> popupWithPresenter: requestPresenter onRightTo: anItem [

	(self newPopover
		 presenter: requestPresenter;
		 relativeTo: anItem;
		 bePositionRight;
		 yourself) popup
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

	self flag: 'to do with polymorphism'.
	
	self selectedChest remove.
	activePresenter == chestWithContentTreeTable ifTrue: [ ^ self ].
	chestsTable selectIndex:
		(1 max: chestsTable selection selectedIndex - 1)
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
ChestTableWithContentPresenter >> requestExpressionToStoreInChest [

	| expression selectedChest expressionName |
	selectedChest := self selectedChest.
	expression := (UIManager default request:
		               ('Enter expression to be stored into ''{1}'''
			                format: { selectedChest name })) ifNil: [ ^ self ].
	expression trim ifEmpty: [ ^ self ].
	expressionName := self
		                  storeExpression: expression
		                  inChest: selectedChest.
	UIManager default inform:
		('Object stored into''{1}'' as ''{2}'' successfully' format: {
				 selectedChest name.
				 expressionName })
]

{ #category : #'ui - dialogs' }
ChestTableWithContentPresenter >> requestNameNewChest [

	| requestPresenter |
	requestPresenter := self presenterToNameNewChest.
	self popupWithPresenter: requestPresenter onRightTo: activePresenter
]

{ #category : #'ui - dialogs' }
ChestTableWithContentPresenter >> requestRenameChest: chest fromContextMenuItem: anItem [

	| requestPresenter |
	requestPresenter := self presenterToRenameChest: chest.
	self popupWithPresenter: requestPresenter onRightTo: anItem
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
	self popupWithPresenter: requestPresenter onRightTo: anItem
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
]

{ #category : #layout }
ChestTableWithContentPresenter >> storeCommandLayout [

	self makeChestContentsTable.

	self chestTableContainer
		removeAll;
		add: inputField expand: false;
		add: chestsTable.
	self chestContentTableContainer
		removeAll;
		add: chestContentsTable.

	^ SpBoxLayout newVertical
		  add: chestTableWithContentContainer;
		  add: (SpBoxLayout newHorizontal
				   add: chestsTableToolbar;
				   add: chestContentsTableToolbar;
				   yourself) expand: false;
		  add: (SpBoxLayout newHorizontal
				   add: buttonNoCopy;
				   add: buttonShallowCopy;
				   add: buttonDeepCopy;
				   yourself);
		  add: confirmActionBar expand: false;
		  yourself
]

{ #category : #'ui - dialogs' }
ChestTableWithContentPresenter >> storeExpression: expression inChest: aChest [

	| result |
	result := Smalltalk compiler
		          source: expression;
		          evaluate.
	^ aChest add: result
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

	self flag: 'to do with polymorphism'.

	activePresenter == chestWithContentTreeTable ifTrue: [ 
		chestWithContentTreeTable roots: Chest allChests.
		^ self ].
	chestContentsTable ifNotNil: [ :lst | 
		lst items: aChest contents associations asOrderedCollection ]
]

{ #category : #updating }
ChestTableWithContentPresenter >> updateChestContentToolbar [

	self updateToolbar: chestContentsTableToolbarCommandGroup
]

{ #category : #updating }
ChestTableWithContentPresenter >> updateChestToolbar [

	self updateToolbar: chestTableToolbarCommandGroup
]

{ #category : #updating }
ChestTableWithContentPresenter >> updateChestsTable [

	self flag: 'to do with polymorphism'.

	activePresenter == chestWithContentTreeTable ifTrue: [ 
		chestWithContentTreeTable roots: Chest allChests.
		^ self ].
	chestsTable ifNotNil: [ :lst | lst items: Chest allChests ]
]

{ #category : #accessing }
ChestTableWithContentPresenter >> updateToolbar: aCmCommandGroup [

	aCmCommandGroup allCommands do: [ :spCommand |
		spCommand updateEnableStatus ]
]

{ #category : #'ui - dialogs' }
ChestTableWithContentPresenter >> warningNamingChest: newChestName [

	^ '`' , newChestName
	  ,
	  '` is the name of a chest that already exists. If you proceed, all objects in the existing chest will be lost. Are you sure you want to proceed?'
]

{ #category : #'ui - dialogs' }
ChestTableWithContentPresenter >> warningNamingObjectInChest: newObjectName [

	^ '`' , newObjectName
	  ,
	  '` is the name of an object that already exists in this chest. If you proceed, this object in the existing chest will be removed and lost. Are you sure you want to proceed?'
]
