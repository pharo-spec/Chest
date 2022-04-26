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

{ #category : #layout }
ChestPresenter class >> defaultLayout [
	| labelHeight topThirdHeight toolbarHeight helpButtonSize bottomRibbonHeight |
	labelHeight := 20.
	topThirdHeight := 200. "Height of playground and other elements on the same horizontal line"
	toolbarHeight := 35.
	helpButtonSize := 35.
	bottomRibbonHeight := 35.
    ^ SpBoxLayout newVertical
			add: (SpPanedLayout newHorizontal 
				add: (SpPanedLayout newHorizontal
					add: (SpBoxLayout newVertical
						add: 'Chests' withConstraints: [:cstr | cstr height: labelHeight];
						add: #chestsTable;
						add: #chestsTableToolbar withConstraints: [:cstr| cstr height: toolbarHeight];
						yourself
					);
					add: (SpBoxLayout newVertical
						add: 'Chest Contents' withConstraints: [:cstr | cstr height: labelHeight];
						add: #chestContentsTable;
						add: #chestContentsTableToolbar withConstraints: [:cstr| cstr height: toolbarHeight];
						yourself
					);
					yourself
				);
				add: #playground;
				yourself
			) withConstraints: [:cstr | cstr height: topThirdHeight];
			add: #inspector;
			add: (SpBoxLayout newHorizontal
				add: 'Use Chests to store and access objects from anywhere';
				add: #helpButton withConstraints: [:c | c height: helpButtonSize; width: helpButtonSize];
				yourself
			) withConstraints: [:c | c height: bottomRibbonHeight];
			yourself
]

{ #category : #specs }
ChestPresenter class >> initialExtent [
	^ 550@500
]

{ #category : #examples }
ChestPresenter class >> open [

	<example>
	| chestPresenter |
	chestPresenter := self newApplication: StPharoApplication new.
	chestPresenter open.
	chestPresenter window extent: self initialExtent.
	^ chestPresenter
]

{ #category : #specs }
ChestPresenter class >> title [
	^ 'Chests'
]

{ #category : #initialization }
ChestPresenter >> event_chestRemoved: aChest [
	self updateChestsTable
]

{ #category : #initialization }
ChestPresenter >> event_contentOfChest: aChest updatedTo: newContents [
	| currentlySelectedChest |
	currentlySelectedChest := chestsTable selectedItems
		                          ifEmpty: [ ^ self ]
		                          ifNotEmpty: [ :selectedItems | 
		                          selectedItems first ].
	currentlySelectedChest == aChest ifTrue: [ 
		self updateChestContentTableForChest: aChest ]
]

{ #category : #initialization }
ChestPresenter >> event_newChest: aChest [
	self updateChestsTable
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

{ #category : #initialization }
ChestPresenter >> initialize [
	super initialize.
	helpExpanded := false.
	Chest subscribeToUpdates: self
]

{ #category : #initialization }
ChestPresenter >> initializeWidgets [
	playground := StPlayground new.
	chestsTable := self makeChestsTable.
	chestsTableToolbar := self makeChestsTableToolbar.
	chestContentsTable := self makeChestContentsTable.
	chestContentsTableToolbar := self makeChestContentsTableToolbar.
	inspector := StInspector on: (StInspectorModel on: nil).
	helpButton := self makeHelpButton.
	chestsTable selectIndex: 1

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

{ #category : #accessing }
ChestPresenter >> insertChestAt: anInteger inPlayground: anStPlayground [
	| textLeftOfTheSelection textRightOfTheSelection textObject textToAdd selectionStart selectionStop |
	textObject := anStPlayground text.
	selectionStart := textObject getSelection instVarNamed: #start.
	selectionStop := textObject getSelection instVarNamed: #stop.
	textLeftOfTheSelection := textObject text first: selectionStart - 1.
	textRightOfTheSelection := textObject text allButFirst: selectionStop.
	textToAdd := '(Chest at: ' , anInteger asString , ')'.
	textObject text:
		textLeftOfTheSelection , textToAdd , textRightOfTheSelection.
	textObject setSelection:
		(textLeftOfTheSelection size + textToAdd size + 1 to:
		 textLeftOfTheSelection size + textToAdd size)


	"playground text text: ((playground text text first: ((playground text getSelection instVarNamed: #start) -1)), '(Chest at: ', item selectedIndex asString, ')',  (playground text text allButFirst:  (playground text getSelection instVarNamed: #stop)))"
]

{ #category : #initialization }
ChestPresenter >> makeChestContentsTable [
	^ self newTable
		  addColumn: ((SpIndexTableColumn title: 'Index') width: 40);
		  addColumn: (SpStringTableColumn
				   title: 'Object'
				   evaluated: [ :obj | obj asString ]);
		  items: OrderedCollection new;
		  whenSelectionChangedDo: [ :selection |
			  inspector model inspectedObject: selection selectedItem.
			  inspector updateList.
]
]

{ #category : #initialization }
ChestPresenter >> makeChestContentsTableToolbar [
	| toolbar |
	toolbar := self newToolbar.
	toolbar addItem: (self newToolbarButton
			 label: 'Remove';
			 icon: (self iconManager iconNamed: #remotesManagerRemoveRemote);
			 action: [ 
				 chestContentsTable selection selectedIndex ifNotNil: [ :index | 
						 index ~= 0 ifTrue: [ 
								 self selectedChest removeAt: index.
								 (chestContentsTable selection selectedIndex = 1 and: [ 
										  chestContentsTable items isNotEmpty ])
									 ifTrue: [ chestContentsTable selectIndex: 1 ]
									 ifFalse: [ 
										 chestContentsTable selectIndex:
												 chestContentsTable selectedIndex - 1 ] ] ] ]).
	toolbar addItem: (self newToolbarButton
			 label: 'Remove All';
			 icon: (self iconManager iconNamed: #glamorousTrash);
			 action: [ 
				 chestContentsTable items ifNotEmpty: [ 
						 chestContentsTable items size to: 1 by: -1 do: [ :index | 
							 self selectedChest removeAt: index ] ] ]).
	^ toolbar
]

{ #category : #initialization }
ChestPresenter >> makeChestsTable [
	^ self newTable
		  addColumn:
			  ((SpStringTableColumn
				    title: 'ID'
				    evaluated: [ :chest | chest id ]) width: 40);
		  addColumn:
			  (SpStringTableColumn
				   title: 'Name'
				   evaluated: [ :chest | chest name ]);
		  items: Chest allChests;
		  whenSelectionChangedDo: [ :selection | 
			  self updateChestContentTableForChest: selection selectedItem.
			  chestContentsTable items ifNotEmpty: [ 
					  chestContentsTable selectIndex: 1 ] ];
		  sortingBlock: [ :chest1 :chest2 | chest1 id < chest2 id ]
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
										 (1 max: chestsTable selectedIndex - 1) ] ] ]).
	toolbar addItem: (self newToolbarButton
			 label: 'Remove All';
			 icon: (self iconManager iconNamed: #glamorousTrash);
			 action: [ chestsTable items copy do: [ :chest | chest remove ] ]).
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
ChestPresenter >> selectedChest [
	^ chestsTable selection selectedItem
]

{ #category : #updating }
ChestPresenter >> updateChestContentTableForChest: aChest [
	chestContentsTable ifNotNil: [ :lst | lst items: aChest contents ]
]

{ #category : #updating }
ChestPresenter >> updateChestsTable [
	chestsTable ifNotNil: [ :lst | lst items: Chest allChests ]
]
