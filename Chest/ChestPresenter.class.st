Class {
	#name : #ChestPresenter,
	#superclass : #SpPresenter,
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
		'inspector'
	],
	#classVars : [
		'contents'
	],
	#category : #Chest
}

{ #category : #'menu-entry' }
ChestPresenter class >> debugWorldMenuOn: aBuilder [
	<worldMenu>
	(aBuilder item: #'Open Chests')
		parent: #Debugging;
		order: 0;
		help: 'Store objects from anywhere to keep them around, check equality...';
		action: [ self open ];
		icon: (Smalltalk ui icons iconNamed: #group).
]

{ #category : #examples }
ChestPresenter class >> open [

	<example>
	| chestPresenter |
	chestPresenter := self newApplication: StPharoApplication new.
	chestPresenter open.

	^ chestPresenter
]

{ #category : #'ui requests' }
ChestPresenter >> confirm: aWarning [

	^ UIManager default
		  confirm: aWarning
		  trueChoice: 'Yes'
		  falseChoice: 'No'
]

{ #category : #layout }
ChestPresenter >> defaultLayout [

	| labelHeight topThirdHeight toolbarHeight helpButtonSize bottomRibbonHeight |
	labelHeight := 20.
	topThirdHeight := 300.
	toolbarHeight := 35.
	helpButtonSize := 35.
	bottomRibbonHeight := 35.
	^ SpBoxLayout newVertical
		  add: (SpPanedLayout newHorizontal
				   add: (SpPanedLayout newHorizontal
						    add: (SpBoxLayout newVertical
								     add:
									     (self
										      headerLayoutWithTitle: 'Chests'
										      withToolbar: #chestsTableToolbar)
								     withConstraints: [ :cstr | cstr height: toolbarHeight ];
								     add: #chestsTable;
								     yourself);
						    add: (SpBoxLayout newVertical
								     add: (self
										      headerLayoutWithTitle: 'Chest Contents'
										      withToolbar: #chestContentsTableToolbar)
								     withConstraints: [ :cstr | cstr height: toolbarHeight ];
								     add: #chestContentsTable;
								     yourself);
						    yourself);
				   add: #playground;
				   yourself)
		  withConstraints: [ :cstr | cstr height: topThirdHeight ];
		  add: #inspector;
		  add: (SpBoxLayout newHorizontal
				   add: 'Use Chests to store and access objects from anywhere';
				   add: #helpButton withConstraints: [ :c | 
					   c
						   height: helpButtonSize;
						   width: helpButtonSize ];
				   yourself)
		  withConstraints: [ :c | c height: bottomRibbonHeight ];
		  yourself
]

{ #category : #initialization }
ChestPresenter >> eventChestRemoved: aChest [
	self updateChestsTable
]

{ #category : #initialization }
ChestPresenter >> eventContentOfChest: aChest updatedTo: newContents [
	| currentlySelectedChest |
	"currentlySelectedChest := chestsTable selectedItems
		                          ifEmpty: [ ^ self ]
		                          ifNotEmpty: [ :selectedItems | 
		                          selectedItems first ]."
	currentlySelectedChest := chestsTable selectedItem.
	currentlySelectedChest == aChest ifTrue: [ 
		self updateChestContentTableForChest: aChest ]
]

{ #category : #initialization }
ChestPresenter >> eventNewChest: aChest [
	self updateChestsTable
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
	^ 800@600
]

{ #category : #initialization }
ChestPresenter >> initialize [
	super initialize.
	helpExpanded := false.
	Chest subscribeToUpdates: self
]

{ #category : #initialization }
ChestPresenter >> initializePresenters [
	playground := StPlayground new.
	chestsTable := self makeChestsTable.
	chestsTableToolbar := self makeChestsTableToolbar.
	chestContentsTable := self makeChestContentsTable.
	chestContentsTableToolbar := self makeChestContentsTableToolbar.
	inspector := StInspector on: (StInspectorModel on: nil).
	helpButton := self makeHelpButton.
	chestsTable selectIndex: 1.
	
	self layout: self defaultLayout 

	"objectTable := self makeObjectTable.
	descriptionLabel := self newLabel label: 'Use Chest to store objects from anywhere'.
	helpButton := self makeHelpButton.
	emptyButton := self newButton
		action: [ ChestPresenter empty ];
		icon: ((self iconNamed: #remove) scaledToSize: 16 @ 16);
		yourself.
	helpTitleLabel := self newLabel label: 'Help'; emphasis: #bold.
	leftSpacerForHelpTitleLabel := SpSpacerPresenter new.
	rightSpacerForHelpTitleLabel := SpSpacerPresenter new.
	helpText := self newText enabled: false; text: self helpText."
]

{ #category : #specs }
ChestPresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: self title;
		initialExtent: self initialExtent
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
					  self performWithObjectNameErrorHandling: [ :newObjectName | 
							  chestsTable selectedItem
								  renameObject: chestContentsTable selectedItem value
								  into: newObjectName ] ] ];
		  addItem: [ :anItem | 
			  anItem
				  name: 'Load';
				  description:
					  'Load the selected object into the playground (or in a global scope ??), in a variable of same name as its key in the chest.';
				  action: [ 
					  playground firstPage interactionModel addBinding:
							  (WorkspaceVariable
								   key: chestContentsTable selectedItem key
								   value: chestContentsTable selectedItem value) ] ];
		  addItem: [ :anItem | 
			  anItem
				  name: 'Load all';
				  description:
					  'Load all objects from the selected chest into the playground (or in a global scope ??), in variables of same name as their key in the chest.';
				  action: [ 
					  playground firstPage interactionModel addBindings:
							  (chestContentsTable items collect: [ :eachAssoc | 
									   WorkspaceVariable
										   key: eachAssoc key
										   value: eachAssoc value ]) ] ]
]

{ #category : #initialization }
ChestPresenter >> makeChestContentsTable [

	^ self newTable
		  addColumn: ((SpStringTableColumn
				    title: 'Name'
				    evaluated: [ :association | association key ]) width: 40);
		  addColumn: (SpStringTableColumn
				   title: 'Object'
				   evaluated: [ :association | association value asString ]);
		  items: OrderedCollection new;
		  contextMenu: self makeChestContentTableContextMenu;
		  whenSelectionChangedDo: [ :selection | 
			  inspector model inspectedObject:
					  (selection selectedItem ifNotNil: [ :association | 
							   association value ]).
			  inspector updateList ]
]

{ #category : #initialization }
ChestPresenter >> makeChestContentsTableToolbar [
	| toolbar |
	toolbar := self newToolbar.
	toolbar addItem: (self newToolbarButton
			 label: 'Remove';
			 icon: (self iconManager iconNamed: #remotesManagerRemoveRemote);
			 action: [ 
				 chestContentsTable selectedItem ifNotNil: [ :assoc | 
								 self selectedChest remove: assoc value.
								 (chestContentsTable selection selectedIndex = 1 and: [ 
										  chestContentsTable items isNotEmpty ])
									 ifTrue: [ chestContentsTable selectIndex: 1 ]
									 ifFalse: [ 
										 chestContentsTable selectIndex:
												 chestContentsTable selection selectedIndex - 1 ] ] ]).
	toolbar addItem: (self newToolbarButton
			 label: 'Remove All';
			 icon: (self iconManager iconNamed: #glamorousTrash);
			 action: [ 
				 chestContentsTable items ifNotEmpty: [ 
						 chestContentsTable items do: [ :assoc | 
							 self selectedChest remove: assoc value ] ] ]).
	^ toolbar
]

{ #category : #initialization }
ChestPresenter >> makeChestTableContextMenu [

	^ self newMenu
		  title: 'Chests';
		  addItem: [ :anItem | 
			  anItem
				  name: 'Rename';
				  description: 'Rename the selected chest';
				  action: [ 
					  self performWithChestNameErrorHandling: [ :newChestName | 
							  chestsTable selectedItem name: newChestName ] ] ];
		  addItem: [ :anItem | 
			  anItem
				  name: 'Load';
				  description:
					  'Load all objects from the selected chest into the playground (or in a global scope ??), in variables of same name as their key in the chest';
				  shortcut: $o meta , $l meta;
				  action: [ 
					  playground firstPage interactionModel addBindings:
							  (chestsTable selectedItem contents associations collect: [ 
									   :each | WorkspaceVariable key: each key value: each value ]) ] ];
		  addItem: [ :anItem | 
			  anItem
				  name: 'Load all';
				  description:
					  'Load all objects from all chests into the playground (or in a global scope ??), in variables of same name as their key in their respective chest';
				  shortcut: $o meta shift , $l meta shift;
				  action: [ 
					  playground firstPage interactionModel addBindings:
							  (chestsTable items flatCollect: [ :each | 
									   each contents associations collect: [ :eachAssoc | 
											   WorkspaceVariable key: eachAssoc key value: eachAssoc value ] ]) ] ]
]

{ #category : #initialization }
ChestPresenter >> makeChestsTable [

	^ self newList
		  items: Chest allChests;
		  contextMenu: self makeChestTableContextMenu;
		  display: [ :chest | chest name ];
		  transmitDo: [ :aChest | 
			  aChest ifNotNil: [ 
					  self updateChestContentTableForChest: aChest.
					  chestContentsTable items ifNotEmpty: [ 
							  chestContentsTable selectIndex: 1 ] ] ];
		  sortingBlock: [ :chest1 :chest2 | chest1 name < chest2 name ];
		  yourself
]

{ #category : #initialization }
ChestPresenter >> makeChestsTableToolbar [

	| toolbar |
	toolbar := self newToolbar.
	toolbar addItem: (self newToolbarButton
			 label: 'Remove';
			 icon: (self iconManager iconNamed: #remotesManagerRemoveRemote);
			 action: [ 
				 chestsTable selection selectedIndex ifNotNil: [ :index | 
						 chestsTable items size >= index ifTrue: [ "index is inside the list's bounds"
								 (chestsTable itemAt: index) remove.
								 chestsTable selectIndex:
										 (1 max: chestsTable selection selectedIndex - 1) ] ] ]).
	toolbar addItem: (self newToolbarButton
			 label: 'Remove All';
			 icon: (self iconManager iconNamed: #glamorousTrash);
			 action: [ chestsTable items copy do: [ :chest | chest remove ] ]).
	toolbar addItem: (self newToolbarButton
			 label: 'add';
			 icon: (self iconManager iconNamed: #add);
			 action: [ 
				 self performWithChestNameErrorHandling: [ :newChestName | 
						 Chest newNamed: newChestName ] ]).
	^ toolbar
]

{ #category : #initialization }
ChestPresenter >> makeHelpButton [
	^ self newButton
		  action: [ UIManager default notify: self helpText ];
		  icon: ((self iconNamed: #help) scaledToSize: 16 @ 16)

	"	^ self newButton
		action: [
			helpExpanded ifFalse: [
				helpExpanded := true.
				extent := self window window extent.
				self window rebuildWithSpecLayout: self class specLayoutHelpExpanded.
				self window extent: (extent + (0@(self class helpPanelHeight))).
				helpButton state: true.]
			ifTrue: [
				helpExpanded := false.
				extent := self window window extent.
				self window rebuildWithSpecLayout: self class defaultSpec.
				self window extent: (extent - (0@(self class helpPanelHeight))).
				helpButton state: false]];
		icon: ((self iconNamed: #help) scaledToSize: 16 @ 16)."
]

{ #category : #updating }
ChestPresenter >> namingQuery [

	^ 'What name do you want to give to your object?'
]

{ #category : #'as yet unclassified' }
ChestPresenter >> performWithChestNameErrorHandling: aBlock [

	| newChestName |
	newChestName := UIManager default request:
		                self namingQuery.
	[(aBlock value: newChestName)]
		on: ChestKeyAlreadyInUseError
		do: [ 
			| chest |
			chest := Chest named: newChestName.
			((self confirm: (self warningNamingChest: newChestName)) and: chest class ~= DefaultChest) ifTrue: [ 
				chest remove.
				aBlock value: newChestName ] ]
]

{ #category : #'as yet unclassified' }
ChestPresenter >> performWithObjectNameErrorHandling: aBlock [

	| newObjectName chest |
	chest := chestsTable selectedItem.
	newObjectName := UIManager default request:
		                self namingQuery.
	[(aBlock value: newObjectName)]
		on: ChestKeyAlreadyInUseError
		do: [ 
			(self confirm: (self warningNamingObjectInChest: newObjectName)) ifTrue: [ 
				chest removeObjectNamed: newObjectName.
				aBlock value: newObjectName ] ]
]

{ #category : #'as yet unclassified' }
ChestPresenter >> selectedChest [
	^ chestsTable selection selectedItem
]

{ #category : #specs }
ChestPresenter >> title [
	^ 'Chests'
]

{ #category : #updating }
ChestPresenter >> updateChestContentTableForChest: aChest [
	chestContentsTable ifNotNil: [ :lst | lst items: aChest contents associations asOrderedCollection ]
]

{ #category : #updating }
ChestPresenter >> updateChestsTable [
	chestsTable ifNotNil: [ :lst | lst items: Chest allChests ]
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
	  ,
	  '` is the name of an object that already exists in this chest. If you proceed, this object in the existing chest will be removed and lost. Are you sure you want to proceed?'
]
