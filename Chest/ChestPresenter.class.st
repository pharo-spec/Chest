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
		'chestContentsTable',
		'inspector',
		'chestTableWithContent'
	],
	#category : #Chest
}

{ #category : #commands }
ChestPresenter class >> buildCommandsGroupWith: aChestWithTablePresenter forRoot: aCmCommandGroup [

	self
		buildLoadChestCommandGroup: aChestWithTablePresenter
		forRoot: aCmCommandGroup.

	self
		buildLoadItemCommandGroup: aChestWithTablePresenter
		forRoot: aCmCommandGroup
]

{ #category : #commands }
ChestPresenter class >> buildLoadChestCommandGroup: aChestWithContentPresenter forRoot: aRoot [

	| group |
	group := (CmCommandGroup named: self loadChestGroupName) asSpecGroup
		         beDisplayedAsGroup;
		         yourself.
	self
		registerClasses: ChestCommand chestLoadChestCommandClasses
		toGroup: group
		withContext: aChestWithContentPresenter.

	aRoot register: group
]

{ #category : #commands }
ChestPresenter class >> buildLoadItemCommandGroup: aChestWithContentPresenter forRoot: aRoot [

	| group |
	group := (CmCommandGroup named: self loadItemGroupName) asSpecGroup
		         beDisplayedAsGroup;
		         yourself.
	self
		registerClasses: ChestCommand chestLoadItemCommandClasses
		toGroup: group
		withContext: aChestWithContentPresenter.

	aRoot register: group
]

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

{ #category : #accessing }
ChestPresenter class >> loadChestGroupName [

	^ 'LoadChest'
]

{ #category : #accessing }
ChestPresenter class >> loadItemGroupName [

	^ 'LoadItem'
]

{ #category : #examples }
ChestPresenter class >> open [

	<example>
	| chestPresenter |
	chestPresenter := self newApplication: StPharoApplication new.
	chestPresenter open.

	^ chestPresenter
]

{ #category : #commands }
ChestPresenter class >> registerClasses: commandClasses toGroup: aGroup withContext: aChestWithContentPresenter [

	commandClasses do: [ :aClass | 
		aGroup register: ((aClass
				  forSpecWithIconNamed: aClass defaultIconName
				  shortcutKey: aClass defaultShortcutKey)
				 context: aChestWithContentPresenter;
				 beHiddenWhenCantBeRun) ]
]

{ #category : #visiting }
ChestPresenter >> accept: aVisitor [

	^ aVisitor visitChest: self
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

{ #category : #accessing }
ChestPresenter >> chestContentsTableToolbar [

	^ chestTableWithContent chestContentsTableToolbar
]

{ #category : #accessing }
ChestPresenter >> chestsTableToolbar [

	^ chestTableWithContent chestsTableToolbar
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

{ #category : #layout }
ChestPresenter >> debuggerLayout [

	^ SpBoxLayout newVertical
		  add:
			  (chestTableWithContent layout:
					   chestTableWithContent debuggerLayout);
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

	chestTableWithContent layout: chestTableWithContent defaultLayout.

	^ SpPanedLayout newHorizontal
		  add: (SpPanedLayout newVertical
				   add: #chestTableWithContent;
				   add: #playground;
				   yourself);
		  add: #inspector;
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
	chestContentsTable := chestTableWithContent chestContentTable.
	self makeChestContentsTable.
	inspector := StInspector on: (StInspectorModel on: nil).
	helpButton := self makeHelpButton.
	chestsTable selectIndex: 1.

	self makeChestTreeTableContextMenu.

	self layout: self defaultLayout
]

{ #category : #initialization }
ChestPresenter >> initializeWindow: aWindowPresenter [

	chestTableWithContent initializeWindow: aWindowPresenter.
	super initializeWindow: aWindowPresenter
]

{ #category : #loading }
ChestPresenter >> loadBindingsFromAllChestsInPlayground [

	^ self addBindingsInPlayground: self collectBindingsFromAllChests
]

{ #category : #loading }
ChestPresenter >> loadBindingsFromSelectedChestInPlayground [

	^ self addBindingsInPlayground:
		  (self collectBindingsFromChest: self selectedChest)
]

{ #category : #adding }
ChestPresenter >> loadSelectedItemBindingInPlayground [

	self addBindingsInPlayground:
		{ (self convertBindingIntoProperWorkspaceVariable: self selectedItem) }
]

{ #category : #initialization }
ChestPresenter >> makeChestContentTableContextMenu [

	| contextMenu |
	contextMenu := [ 
	               (CmCommandGroup new
		                register: chestTableWithContent rootCommandsGroup
			                /
				                chestTableWithContent class
					                chestContentMenuGroupName;
		                register:
			                self rootCommandsGroup
			                / self class loadItemGroupName) asSpecGroup beRoot
		               asMenuPresenter ].
	chestContentsTable contextMenu: contextMenu
]

{ #category : #initialization }
ChestPresenter >> makeChestContentsTable [

	self makeChestContentTableContextMenu.
	^ chestContentsTable
		  whenSelectionChangedDo: [ :selection | 
			  inspector model inspectedObject:
					  (selection selectedItem ifNotNil: [ :association | 
							   association value ]).
			  inspector updateList ];
		  applyKeyBindingsFromMenu: chestContentsTable contextMenu value;
		  yourself
]

{ #category : #initialization }
ChestPresenter >> makeChestTableContextMenu [

	| contextMenu |
	contextMenu := [ 
	               (CmCommandGroup new
		                register: chestTableWithContent rootCommandsGroup
			                / chestTableWithContent class chestMenuGroupName;
		                register:
			                self rootCommandsGroup
			                / self class loadChestGroupName) asSpecGroup beRoot
		               asMenuPresenter ].
	chestsTable contextMenu: contextMenu
]

{ #category : #initialization }
ChestPresenter >> makeChestTreeTableContextMenu [

	| contextMenu |
	contextMenu := [ 
	               (CmCommandGroup new
		                register: (chestTableWithContent rootCommandsGroup
			                /
				                chestTableWithContent class
					                chestWithContentMenuGroupName);
		                register:
			                (self rootCommandsGroup
			                / self class loadChestGroupName);
		                register:
			                self rootCommandsGroup
			                / self class loadItemGroupName) asSpecGroup beRoot
		               asMenuPresenter ].
	chestTableWithContent chestWithContentTreeTable
		contextMenu: contextMenu;
		applyKeyBindingsFromMenu: contextMenu value
]

{ #category : #initialization }
ChestPresenter >> makeChestsTable [

	self makeChestTableContextMenu.
	^ chestsTable
		  applyKeyBindingsFromMenu: chestsTable contextMenu value;
		  yourself
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

{ #category : #removing }
ChestPresenter >> removeAllChests [

	chestTableWithContent removeAllChests
]

{ #category : #removing }
ChestPresenter >> removeAllItemsFromSelectedChest [

	chestTableWithContent removeAllItemsFromSelectedChest
]

{ #category : #removing }
ChestPresenter >> removeSelectedChest [

	chestTableWithContent removeSelectedChest
]

{ #category : #removing }
ChestPresenter >> removeSelectedItem [

	chestTableWithContent removeSelectedItem
]

{ #category : #renaming }
ChestPresenter >> renameSelectedChest [

	^ chestTableWithContent renameSelectedChest
]

{ #category : #renaming }
ChestPresenter >> renameSelectedItem [

	^ chestTableWithContent renameSelectedItem
]

{ #category : #'ui - dialogs' }
ChestPresenter >> requestNameNewChest [

	chestTableWithContent requestNameNewChest
]

{ #category : #accessing }
ChestPresenter >> selectedChest [

	^ chestTableWithContent selectedChest
]

{ #category : #accessing }
ChestPresenter >> selectedItem [

	^ chestTableWithContent selectedItem
]

{ #category : #initialization }
ChestPresenter >> setModelBeforeInitialization: aStDebugger [

	debugger := aStDebugger
]

{ #category : #specs }
ChestPresenter >> title [

	^ 'Chests'
]
