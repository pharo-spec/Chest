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

{ #category : #adding }
ChestPresenter >> addBindingsInPlayground: aCollectionOfBindings [

	playground firstPage interactionModel addBindings: aCollectionOfBindings 
]

{ #category : #'as yet unclassified' }
ChestPresenter >> buildChestContentTableContainerLayout [

	chestTableWithContent chestContentTableContainer
		removeAll;
		add: (self
				 headerLayoutWithTitle: 'Chest Contents'
				 withToolbar: chestContentsTableToolbar)
		withConstraints: [ :cstr | cstr height: 35 ];
		add: #chestContentsTable
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

	^ chestsTable items flatCollect: [ :each | self collectBindingsFromChest: each ] 
]

{ #category : #'as yet unclassified' }
ChestPresenter >> collectBindingsFromChest: aChest [

	^ aChest contents associations collect: [ :each | 
		  self convertBindingIntoProperWorkspaceVariable: each ]
]

{ #category : #'ui requests' }
ChestPresenter >> confirm: aWarning [

	^ SpConfirmDialog new
		  title: 'Warning !';
		  label: aWarning;
		  acceptLabel: 'Yes';
		  cancelLabel: 'No'
]

{ #category : #'as yet unclassified' }
ChestPresenter >> convertBindingIntoProperWorkspaceVariable: aBinding [

	^ WorkspaceVariable key: aBinding key value: aBinding value
]

{ #category : #layout }
ChestPresenter >> defaultLayout [

	| labelHeight topThirdHeight toolbarHeight helpButtonSize bottomRibbonHeight |
	labelHeight := 20.
	topThirdHeight := 300.
	toolbarHeight := 35.
	helpButtonSize := 35.
	bottomRibbonHeight := 35.
	self buildChestTableContainerLayout; buildChestContentTableContainerLayout.
	
	^ SpBoxLayout newVertical
		  add: (SpPanedLayout newHorizontal
				   add: #chestTableWithContent;
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

{ #category : #initialization }
ChestPresenter >> makeChestContentTableContextMenu [

	^ self newMenu
		  title: 'Chest Contents';
		  addItem: [ :anItem | 
			  anItem
				  name: 'Rename';
				  description: 'Rename the selected item in chest';
				  action: [ 
					  | keyValueAssocForObject |
					  keyValueAssocForObject := chestContentsTable selectedItem.
					  (self namingDialog
						   title: 'Rename object in chest';
						   onAccept: [ :aDialog | 
							   self
								   performWithObjectNameErrorHandling: [ :newObjectName | 
									   chestsTable selectedItem
										   renameObject: keyValueAssocForObject value
										   into: newObjectName ]
								   withDialog: aDialog presenter ]) openDialogWithParent: anItem ] ];
		  addItem: [ :anItem | 
			  anItem
				  name: 'Load';
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
				  action: [ 
					  self addBindingsInPlayground:
							  (self collectBindingsFromChest: chestsTable selectedChest) ] ]
]

{ #category : #initialization }
ChestPresenter >> makeChestContentsTable [

	^ chestContentsTable
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
				  description: 'Rename the selected chest';
				  action: [ 
					  | chest |
					  chest := chestsTable selectedItem.
					  (self namingDialog
						   title: 'Name Chest';
						   onAccept: [ :dialog | 
							   self
								   performWithChestNameErrorHandling: [ :newChestName | 
									   chest name: newChestName ]
								   withDialog: dialog presenter ]) openDialogWithParent:
						  anItem ] ];
		  addItem: [ :anItem | 
			  anItem
				  name: 'Load';
				  description:
					  'Load all objects from the selected chest into the playground (or in a global scope ??), in variables of same name as their key in the chest';
				  shortcut: $o meta , $l meta;
				  action: [ 
					  self addBindingsInPlayground:
							  (self collectBindingsFromChest: chestsTable selectedItem) ] ];
		  addItem: [ :anItem | 
			  anItem
				  name: 'Load all';
				  description:
					  'Load all objects from all chests into the playground (or in a global scope ??), in variables of same name as their key in their respective chest';
				  shortcut: $o meta shift , $l meta shift;
				  action: [ 
					  self addBindingsInPlayground: self collectBindingsFromAllChests ] ]
]

{ #category : #initialization }
ChestPresenter >> makeChestsTable [

	chestsTable contextMenu: self makeChestTableContextMenu 
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
			 action: [ 
				 (self namingDialog
					  title: 'Name Chest';
					  onAccept: [ :dialog | 
						  self
							  performWithChestNameErrorHandling: [ :newChestName | 
								  Chest newNamed: newChestName ]
							  withDialog: dialog presenter ]) openDialogWithParent: toolbar ]).
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

{ #category : #'as yet unclassified' }
ChestPresenter >> namingDialog [

	^ SpRequestTextDialog new
		  title: 'Name Chest';
		  label: self namingQuery;
		  acceptLabel: 'Confirm';
		  extent: 500 @ 160;
		  cancelLabel: 'Cancel'
]

{ #category : #updating }
ChestPresenter >> namingQuery [

	^ 'What name do you want to give to your object?'
]

{ #category : #'as yet unclassified' }
ChestPresenter >> performWithChestNameErrorHandling: aBlock withDialog: aDialog [

	| newChestName |
	newChestName := aDialog text.
	[ aBlock value: newChestName ]
		on: ChestKeyAlreadyInUseError
		do: [ 
			| chest |
			chest := Chest named: newChestName.
			((self confirm: (self warningNamingChest: newChestName)) onAccept: [ 
				 :dialog | 
				 chest class ~= DefaultChest
					 ifTrue: [ 
						 chest remove.
						 aBlock value: newChestName ]
					 ifFalse: [ 
					 dialog presenter inform: newChestName , ' could not be removed.' ] ]) 
				openDialogWithParent: aDialog ]
]

{ #category : #'as yet unclassified' }
ChestPresenter >> performWithObjectNameErrorHandling: aBlock withDialog: aDialog [

	| newObjectName chest |
	chest := chestsTable selectedItem.
	newObjectName := aDialog text.
	[(aBlock value: newObjectName)]
		on: ChestKeyAlreadyInUseError
		do: [ 
			((self confirm: (self warningNamingObjectInChest: newObjectName)) onAccept: [ 
				chest removeObjectNamed: newObjectName.
				aBlock value: newObjectName ]) openDialogWithParent: chestContentsTable ]
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
