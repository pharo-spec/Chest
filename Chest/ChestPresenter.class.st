"
Presenter used to visualize chests and their contents. This is also a debugger extension.
"
Class {
	#name : #ChestPresenter,
	#superclass : #SpPresenter,
	#traits : 'TStDebuggerExtension',
	#classTraits : 'TStDebuggerExtension classTrait',
	#instVars : [
		'playground',
		'helpButton',
		'emptyButton',
		'helpExpanded',
		'descriptionLabel',
		'helpTitleLabel',
		'leftSpacerForHelpTitleLabel',
		'rightSpacerForHelpTitleLabel',
		'helpText',
		'objectTable',
		'chestsTable',
		'chestsTableToolbar',
		'chestContentsTable',
		'chestContentsTableToolbar',
		'inspector',
		'chestTableWithContent'
	],
	#category : #Chest
}

{ #category : #'menu-entry' }
ChestPresenter class >> debugWorldMenuOn: aBuilder [

	<worldMenu>
	(aBuilder item: #'Open Chests')
		parent: #Debugging;
		order: 0;
		help:
			'Store objects from anywhere to keep them around, check equality...';
		action: [ self open ];
		icon: (Smalltalk ui icons iconNamed: #group)
]

{ #category : #examples }
ChestPresenter class >> open [

	<example>
	| chestPresenter |
	chestPresenter := self newApplication: StPharoApplication new.
	chestPresenter open.

	^ chestPresenter
]

{ #category : #adding }
ChestPresenter >> addBindingsInPlayground: aCollectionOfBindings [

	playground firstPage interactionModel addBindings:
		aCollectionOfBindings
]

{ #category : #adding }
ChestPresenter >> addButtonsToPresenter: aDialogPresenter withConfirmAction: aBlock [

	| dialogLayout |
	dialogLayout := aDialogPresenter layout.
	dialogLayout add: (SpButtonPresenter new
			 label: 'Confirm';
			 action: aBlock;
			 yourself)
]

{ #category : #'as yet unclassified' }
ChestPresenter >> buildChestContentTableContainerLayout [

	chestTableWithContent chestContentTableContainer
		removeAll;
		add: (self
				 headerLayoutWithTitle: 'Chest Contents'
				 withToolbar: chestContentsTableToolbar)
		withConstraints: [ :cstr | cstr height: 35 ];
		add: chestTableWithContent chestContentTable
]

{ #category : #'as yet unclassified' }
ChestPresenter >> buildChestTableContainerLayout [

	chestTableWithContent chestTableContainer
		removeAll;
		add:
			(self
				 headerLayoutWithTitle: 'Chests'
				 withToolbar: chestsTableToolbar)
		withConstraints: [ :cstr | cstr height: 35 ];
		add: chestTableWithContent chestsTable
]

{ #category : #'as yet unclassified' }
ChestPresenter >> collectBindingsFromAllChests [

	^ chestsTable items flatCollect: [ :each | 
		  self collectBindingsFromChest: each ]
]

{ #category : #'as yet unclassified' }
ChestPresenter >> collectBindingsFromChest: aChest [

	^ aChest contents associations collect: [ :each | 
		  self convertBindingIntoProperWorkspaceVariable: each ]
]

{ #category : #'as yet unclassified' }
ChestPresenter >> convertBindingIntoProperWorkspaceVariable: aBinding [

	^ WorkspaceVariable key: aBinding key value: aBinding value
]

{ #category : #'debugger extension' }
ChestPresenter >> debuggerExtensionToolName [

	^ 'Chest'
]

{ #category : #'as yet unclassified' }
ChestPresenter >> debuggerLayout [

	self
		buildChestTableContainerLayout;
		buildChestContentTableContainerLayout.

	^ SpBoxLayout newVertical
		  add: chestTableWithContent;
		  add: playground;
		  yourself
]

{ #category : #layout }
ChestPresenter >> defaultLayout [

	| labelHeight topThirdHeight toolbarHeight helpButtonSize bottomRibbonHeight |
	labelHeight := 20.
	topThirdHeight := 300.
	toolbarHeight := 35.
	helpButtonSize := 35.
	bottomRibbonHeight := 35.
	self
		buildChestTableContainerLayout;
		buildChestContentTableContainerLayout.

	^ SpPanedLayout newHorizontal
		  add: (SpPanedLayout newVertical
				   add: #chestTableWithContent;
				   add: #playground;
				   yourself);
		  add: #inspector;
		  yourself
]

{ #category : #'as yet unclassified' }
ChestPresenter >> headerLayoutWithTitle: aString withToolbar: aToolbar [

	^ SpBoxLayout newHorizontal
		  add: aString expand: false;
		  addLast: aToolbar expand: false;
		  yourself
]

{ #category : #updating }
ChestPresenter >> helpText [

	^ 'THIS IS THE HELP FOR CHESTS' , Character cr asString
	  , Character cr asString , 'ID' , Character cr asString
	  ,
	  '	Each Chest instance has an ID (Integer). These IDs are unique. No two Chest can ever have the same ID (unless of course one re-initialize the Chest class).'
	  , Character cr asString , Character cr asString , 'Default Chest'
	  , Character cr asString
	  ,
	  '	This is an instance of Chest that always exists, always has ID = 1, and can be interacted with in the same way as any other Chest by sending the messages to the Chest class.'
	  , Character cr asString , Character cr asString , 'API'
	  , Character cr asString , '	Chest class' , Character cr asString
	  , '		#new' , Character cr asString
	  , '			Create and return a new Chest' , Character cr asString
	  , '		#newNamed: aString' , Character cr asString
	  , '			Create and return a new Chest, with the provided name'
	  , Character cr asString , '		#withId: anInteger'
	  , Character cr asString
	  , '			Return the Chest whose ID is @anInteger'
	  , Character cr asString , Character cr asString , '	Chest instance'
	  , Character cr asString , '		#add: anObject'
	  , Character cr asString , '			Add anObject to this Chest'
	  , Character cr asString , '		#at: anInteger'
	  , Character cr asString
	  , '			Gets the object stored in this Chest at index @anInteger'
	  , Character cr asString , '		#contents' , Character cr asString
	  ,
	  '			Gets an OrderedCollection with the content of this Chest. This collection is a copy so editing it directly does not affect this Chest.'
	  , Character cr asString , '		#empty' , Character cr asString
	  , '			Removes all objects from this Chest' , Character cr asString
	  , '		#name' , Character cr asString
	  , '			Gets the name of this Chest' , Character cr asString
	  , '		#id' , Character cr asString , '			Gets the ID of this Chest'
	  , Character cr asString , '		#remove' , Character cr asString
	  ,
	  '			Destroy this Chest (it will no longer appear in the Chest UI)'
	  , Character cr asString , '		#remove: anObject'
	  , Character cr asString , '			Remove @anObject from this Chest'
	  , Character cr asString , '		#removeAt: anInteger'
	  , Character cr asString
	  , '			Remove the object ar index @anInteger from this Chest'
]

{ #category : #'as yet unclassified' }
ChestPresenter >> iconManager [

	^ Smalltalk ui icons
]

{ #category : #specs }
ChestPresenter >> initialExtent [

	^ 800 @ 600
]

{ #category : #initialization }
ChestPresenter >> initialize [

	super initialize.
	helpExpanded := false
]

{ #category : #initialization }
ChestPresenter >> initializePresenters [

	playground := self makePlayground.
	chestTableWithContent := ChestTableWithContentPresenter new.
	chestsTable := chestTableWithContent chestsTable.
	self makeChestsTable.
	chestsTableToolbar := self makeChestsTableToolbar.
	chestContentsTable := chestTableWithContent chestContentTable.
	self makeChestContentsTable.
	chestContentsTableToolbar := self makeChestContentsTableToolbar.
	inspector := StInspector on: (StInspectorModel on: nil).
	helpButton := self makeHelpButton.
	chestsTable selectIndex: 1.

	self layout: self defaultLayout
]

{ #category : #initialization }
ChestPresenter >> initializeWindow: aWindowPresenter [

	chestTableWithContent initializeWindow: aWindowPresenter.
	super initializeWindow: aWindowPresenter
]

{ #category : #initialization }
ChestPresenter >> makeChestContentTableContextMenu [

	^ self newMenu
		  title: 'Chest Contents';
		  addItem: [ :anItem | 
			  anItem
				  name: 'Rename';
				  description: 'Rename the selected item in chest';
				  action: [ 
					  self
						  requestRenameObjectFromChest:
							  chestContentsTable selectedItem value
						  fromContextMenuItem: anItem ] ];
		  addItem: [ :anItem | 
			  anItem
				  name: 'Load';
				  shortcut: $l meta;
				  description:
					  'Load the selected object into the playground (or in a global scope ??), in a variable of same name as its key in the chest.';
				  action: [ 
					  self addBindingsInPlayground:
							  { (self convertBindingIntoProperWorkspaceVariable:
									   chestContentsTable selectedItem) } ] ];
		  addItem: [ :anItem | 
			  anItem
				  name: 'Load all';
				  description:
					  'Load all objects from the selected chest into the playground (or in a global scope ??), in variables of same name as their key in the chest.';
				  shortcut: $l shift meta;
				  action: [ 
					  self addBindingsInPlayground:
							  (self collectBindingsFromChest: self selectedChest) ] ];
		  addItem: [ :anItem | 
			  anItem
				  name: 'Inspect';
				  shortcut: $i meta;
				  action: [ chestContentsTable selectedItem value inspect ] ]
]

{ #category : #initialization }
ChestPresenter >> makeChestContentsTable [

	^ chestContentsTable
		  contextMenu: self makeChestContentTableContextMenu;
		  whenSelectionChangedDo: [ :selection | 
			  inspector model inspectedObject:
					  (selection selectedItem ifNotNil: [ :association | 
							   association value ]).
			  inspector updateList ];
		  applyKeyBindingsFromMenu: chestContentsTable contextMenu;
		  yourself
]

{ #category : #initialization }
ChestPresenter >> makeChestContentsTableToolbar [

	| toolbar |
	toolbar := self newToolbar.
	toolbar addItem: (self newToolbarButton
			 label: 'Remove';
			 icon: (self iconManager iconNamed: #remotesManagerRemoveRemote);
			 action: [ self removeSelectedItem ]).
	toolbar addItem: (self newToolbarButton
			 label: 'Remove All';
			 icon: (self iconManager iconNamed: #glamorousTrash);
			 action: [ self removeAllItemsFromSelectedChest ]).
	^ toolbar
]

{ #category : #initialization }
ChestPresenter >> makeChestTableContextMenu [

	^ self newMenu
		  title: 'Chests';
		  addItem: [ :anItem | 
			  anItem
				  name: 'Rename';
				  shortcut: $r meta;
				  description: 'Rename the selected chest';
				  action: [ 
					  self
						  requestRenameChest: chestsTable selectedItem
						  fromContextMenuItem: anItem ] ];
		  addItem: [ :anItem | 
			  anItem
				  name: 'Load';
				  shortcut: $l meta;
				  description:
					  'Load all objects from the selected chest into the playground (or in a global scope ??), in variables of same name as their key in the chest';
				  action: [ "$o meta , $l meta"
					  self addBindingsInPlayground:
							  (self collectBindingsFromChest: chestsTable selectedItem) ] ];
		  addItem: [ :anItem | 
			  anItem
				  name: 'Load all';
				  shortcut: $l shift meta;
				  description:
					  'Load all objects from all chests into the playground (or in a global scope ??), in variables of same name as their key in their respective chest';
				  action: [ 
					  self addBindingsInPlayground: self collectBindingsFromAllChests ] ]
]

{ #category : #initialization }
ChestPresenter >> makeChestsTable [

	^ chestsTable
		  contextMenu: self makeChestTableContextMenu;
		  applyKeyBindingsFromMenu: chestsTable contextMenu;
		  yourself
]

{ #category : #initialization }
ChestPresenter >> makeChestsTableToolbar [

	| toolbar |
	toolbar := self newToolbar.
	toolbar addItem: (self newToolbarButton
			 label: 'Remove';
			 icon: (self iconManager iconNamed: #remotesManagerRemoveRemote);
			 action: [ self removeSelectedChest ]).
	toolbar addItem: (self newToolbarButton
			 label: 'Remove All';
			 icon: (self iconManager iconNamed: #glamorousTrash);
			 action: [ self removeAllChests ]).
	toolbar addItem: (self newToolbarButton
			 label: 'add';
			 icon: (self iconManager iconNamed: #add);
			 action: [ self requestNameNewChestFromToolbar: toolbar ]).
	^ toolbar
]

{ #category : #initialization }
ChestPresenter >> makeHelpButton [

	^ self newButton
		  action: [ UIManager default notify: self helpText ];
		  icon: ((self iconNamed: #help) scaledToSize: 16 @ 16)
]

{ #category : #'as yet unclassified' }
ChestPresenter >> makePlayground [

	| newPlayground |
	newPlayground := StPlayground new.

	debugger ifNotNil: [ "newPlayground firstPage text interactionModel"
		newPlayground firstPage text interactionModel:
			(ChestCodeScriptingInteractionModel debugger: debugger) ].

	^ newPlayground
]

{ #category : #updating }
ChestPresenter >> namingQuery [

	^ 'What name do you want to give to your object?'
]

{ #category : #'as yet unclassified' }
ChestPresenter >> presenterToNameNewChest [

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

{ #category : #'as yet unclassified' }
ChestPresenter >> presenterToRenameChest: chest [

	^ ChestRequestDialogPresenter
		  request: self namingQuery
		  onAccept: [ :newChestName | 
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
]

{ #category : #'as yet unclassified' }
ChestPresenter >> presenterToRenameObject: object inChest: chest [

	^ ChestRequestDialogPresenter
		  request: self namingQuery
		  onAccept: [ :name | 
			  [ chest renameObject: object into: name ]
				  on: ChestKeyAlreadyInUseError
				  do: [ 
					  (self confirm: (self warningNamingObjectInChest: name)) 
						  ifTrue: [ 
							  chest removeObjectNamed: name.
							  chest renameObject: object into: name ] ] ]
]

{ #category : #removing }
ChestPresenter >> removeAllChests [

	chestsTable items copy do: [ :chest | chest remove ]
]

{ #category : #removing }
ChestPresenter >> removeAllItemsFromSelectedChest [

	chestContentsTable items ifNotEmpty: [ 
		chestContentsTable items do: [ :assoc | 
			self selectedChest remove: assoc value ] ]
]

{ #category : #removing }
ChestPresenter >> removeSelectedChest [

	chestsTable selection selectedIndex ifNotNil: [ :index | 
		chestsTable items size >= index ifTrue: [ "index is inside the list's bounds"
			(chestsTable itemAt: index) remove.
			chestsTable selectIndex:
				(1 max: chestsTable selection selectedIndex - 1) ] ]
]

{ #category : #removing }
ChestPresenter >> removeSelectedItem [

	chestContentsTable selectedItem ifNotNil: [ :assoc | 
		self selectedChest remove: assoc value.
		(chestContentsTable selection selectedIndex = 1 and: [ 
			 chestContentsTable items isNotEmpty ])
			ifTrue: [ chestContentsTable selectIndex: 1 ]
			ifFalse: [ 
				chestContentsTable selectIndex:
					chestContentsTable selection selectedIndex - 1 ] ]
]

{ #category : #initialization }
ChestPresenter >> requestNameNewChestFromToolbar: toolbar [

	| requestPresenter |
	requestPresenter := self presenterToNameNewChest.
	(self newPopover
		 presenter: requestPresenter;
		 relativeTo: toolbar;
		 bePositionRight;
		 yourself) popup
]

{ #category : #initialization }
ChestPresenter >> requestRenameChest: chest fromContextMenuItem: anItem [

	| requestPresenter |
	requestPresenter := self presenterToRenameChest: chest.
	(self newPopover
		 presenter: requestPresenter;
		 relativeTo: anItem;
		 bePositionRight;
		 yourself) popup
]

{ #category : #initialization }
ChestPresenter >> requestRenameObjectFromChest: object fromContextMenuItem: anItem [

	| chest requestPresenter |
	chest := chestsTable selectedItem.
	requestPresenter := self
		                    presenterToRenameObject: object
		                    inChest: chest.
	(self newPopover
		 presenter: requestPresenter;
		 relativeTo: anItem;
		 bePositionRight;
		 yourself) popup
]

{ #category : #'as yet unclassified' }
ChestPresenter >> selectedChest [

	^ chestsTable selection selectedItem
]

{ #category : #initialization }
ChestPresenter >> setModelBeforeInitialization: aStDebugger [

	debugger := aStDebugger
]

{ #category : #specs }
ChestPresenter >> title [

	^ 'Chests'
]

{ #category : #updating }
ChestPresenter >> warningNamingChest: newChestName [

	^ '`' , newChestName
	  ,
	  '` is the name of a chest that already exists. If you proceed, all objects in the existing chest will be lost. Are you sure you want to proceed?'
]

{ #category : #'as yet unclassified' }
ChestPresenter >> warningNamingObjectInChest: newObjectName [

	^ '`' , newObjectName
	  , '` already exists in this chest. Do you want to replace it?'
]
