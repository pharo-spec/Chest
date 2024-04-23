"
Presenter used to visualize chests and their contents. This is also a debugger extension.
"
Class {
	#name : 'ChestPresenter',
	#superclass : 'SpPresenter',
	#traits : 'TStDebuggerExtension',
	#classTraits : 'TStDebuggerExtension classTrait',
	#instVars : [
		'playground',
		'chestsTable',
		'chestContentsTable',
		'inspector',
		'chestTableWithContent',
		'showPlaygroundButton',
		'showInspectorButton',
		'showPlaygroundContainer',
		'showInspectorContainer',
		'globalContainer'
	],
	#classVars : [
		'ShowInspector',
		'ShowPlayground'
	],
	#category : 'Chest',
	#package : 'Chest'
}

{ #category : 'commands' }
ChestPresenter class >> buildCommandsGroupWith: aChestWithTablePresenter forRoot: aCmCommandGroup [

	self
		buildLoadChestCommandGroup: aChestWithTablePresenter
		forRoot: aCmCommandGroup.

	self
		buildLoadItemCommandGroup: aChestWithTablePresenter
		forRoot: aCmCommandGroup
]

{ #category : 'commands' }
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

{ #category : 'commands' }
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

{ #category : 'settings' }
ChestPresenter class >> chestSettingsOn: aBuilder [

	<systemsettings>
	(aBuilder group: #ChestTool)
		label: 'Chest';
		parent: #tools;
		description: 'Settings related to the Chest tool';
		with: [
			(aBuilder setting: #showPlayground)
				label: 'Shows playground in Chest';
				target: self;
				default: self showPlayground;
				description: 'Shows a playground below chests and their contents.'.
			(aBuilder setting: #showInspector)
				label: 'Shows inspector in Chest';
				target: self;
				default: self showInspector;
				description:
					'Shows an inspector on the right to chests and their contents, on the selected chest item' ]
]

{ #category : 'menu-entry' }
ChestPresenter class >> debugWorldMenuOn: aBuilder [

	<worldMenu>
	(aBuilder group: #Chest)
		parent: #Debug;
		order: 10;
		withSeparatorAfter;
		with: [
			(aBuilder item: #'Open Chests')
				order: 1;
				help:
					'Store objects from anywhere to keep them around, check equality...';
				action: [ self open ];
				icon: (Smalltalk ui icons iconNamed: #group) ]
]

{ #category : 'accessing' }
ChestPresenter class >> loadChestGroupName [

	^ 'LoadChest'
]

{ #category : 'accessing' }
ChestPresenter class >> loadItemGroupName [

	^ 'LoadItem'
]

{ #category : 'examples' }
ChestPresenter class >> open [

	<example>
	| chestPresenter |
	chestPresenter := self newApplication: StPharoApplication new.
	chestPresenter open.

	^ chestPresenter
]

{ #category : 'commands' }
ChestPresenter class >> registerClasses: commandClasses toGroup: aGroup withContext: aChestWithContentPresenter [

	commandClasses do: [ :aClass | 
		aGroup register: ((aClass
				  forSpecWithIconNamed: aClass defaultIconName
				  shortcutKey: aClass defaultShortcutKey)
				 context: aChestWithContentPresenter;
				 beHiddenWhenCantBeRun) ]
]

{ #category : 'accessing' }
ChestPresenter class >> showInspector [

	^ ShowInspector ifNil: [ ShowInspector := false ]
]

{ #category : 'accessing' }
ChestPresenter class >> showInspector: anObject [

	ShowInspector := anObject
]

{ #category : 'accessing' }
ChestPresenter class >> showPlayground [

	^ ShowPlayground ifNil: [ ShowPlayground := false ]
]

{ #category : 'accessing' }
ChestPresenter class >> showPlayground: anObject [

	ShowPlayground := anObject
]

{ #category : 'visiting' }
ChestPresenter >> accept: aVisitor [

	^ aVisitor visitChest: self
]

{ #category : 'adding' }
ChestPresenter >> addBindingsInPlayground: aCollectionOfBindings [

	playground firstPage interactionModel addBindings:
		aCollectionOfBindings
]

{ #category : 'adding' }
ChestPresenter >> addButtonsToPresenter: aDialogPresenter withConfirmAction: aBlock [

	| dialogLayout |
	dialogLayout := aDialogPresenter layout.
	dialogLayout add: (SpButtonPresenter new
			 label: 'Confirm';
			 action: aBlock;
			 yourself)
]

{ #category : 'accessing' }
ChestPresenter >> chestContentsTableToolbar [

	^ chestTableWithContent chestContentsTableToolbar
]

{ #category : 'accessing' }
ChestPresenter >> chestsTableToolbar [

	^ chestTableWithContent chestsTableToolbar
]

{ #category : 'binding' }
ChestPresenter >> collectBindingsFromAllChests [

	^ chestsTable items flatCollect: [ :each | 
		  self collectBindingsFromChest: each ]
]

{ #category : 'binding' }
ChestPresenter >> collectBindingsFromChest: aChest [

	^ aChest contents associations collect: [ :each | 
		  self convertBindingIntoProperWorkspaceVariable: each ]
]

{ #category : 'converting' }
ChestPresenter >> convertBindingIntoProperWorkspaceVariable: aBinding [

	^ WorkspaceVariable key: aBinding key value: aBinding value
]

{ #category : 'debugger extension' }
ChestPresenter >> debuggerExtensionToolName [

	^ 'Chest'
]

{ #category : 'layout' }
ChestPresenter >> debuggerLayout [

	^ SpBoxLayout newVertical
		  add:
			  (chestTableWithContent layout:
					   chestTableWithContent debuggerLayout);
		  add: playground;
		  yourself
]

{ #category : 'layout' }
ChestPresenter >> defaultLayout [

	| labelHeight topThirdHeight toolbarHeight helpButtonSize bottomRibbonHeight |
	labelHeight := 20.
	topThirdHeight := 300.
	toolbarHeight := 35.
	helpButtonSize := 35.
	bottomRibbonHeight := 35.

	chestTableWithContent layout: chestTableWithContent defaultLayout.
	chestsTable := chestTableWithContent chestsTable.
	chestContentsTable := chestTableWithContent chestContentTable.
	self
		makeChestsTable;
		makeChestContentsTable.

	^ globalContainer
]

{ #category : 'layout' }
ChestPresenter >> displayInspector [

	showInspectorContainer := SpBoxLayout newHorizontal
		                          add: showInspectorButton expand: false;
		                          add: inspector;
		                          yourself.
	globalContainer := SpPanedLayout newHorizontal
		                   add: showPlaygroundContainer;
		                   add: showInspectorContainer;
		                   yourself.
	showInspectorButton icon: (self application iconNamed: #enable)
]

{ #category : 'layout' }
ChestPresenter >> displayPlayground [

	showPlaygroundContainer add: playground.
	showPlaygroundButton icon: (self application iconNamed: #enable)
]

{ #category : 'layout' }
ChestPresenter >> headerLayoutWithTitle: aString withToolbar: aToolbar [

	^ SpBoxLayout newHorizontal
		  add: aString expand: false;
		  addLast: aToolbar expand: false;
		  yourself
]

{ #category : 'layout' }
ChestPresenter >> hideInspector [

	showInspectorContainer := showInspectorButton.
	globalContainer := SpBoxLayout newHorizontal
		                   add: showPlaygroundContainer;
		                   add: showInspectorContainer expand: false;
		                   yourself.
	showInspectorButton icon: (self application iconNamed: #disable)
]

{ #category : 'layout' }
ChestPresenter >> hidePlayground [

	showPlaygroundContainer remove: playground.
	showPlaygroundButton icon: (self application iconNamed: #disable)
]

{ #category : 'helper' }
ChestPresenter >> iconManager [

	^ Smalltalk ui icons
]

{ #category : 'specs' }
ChestPresenter >> initialExtent [

	^ 800 @ 600
]

{ #category : 'initialization' }
ChestPresenter >> initialize [

	super initialize
]

{ #category : 'initialization' }
ChestPresenter >> initializePresenters [

	playground := self makePlayground.
	chestTableWithContent := ChestTableWithContentPresenter new.
	chestsTable := chestTableWithContent chestsTable.
	self makeChestsTable.
	chestContentsTable := chestTableWithContent chestContentTable.
	self makeChestContentsTable.
	inspector := StInspector on: (StInspectorModel on: nil).
	chestsTable selectIndex: 1.

	self makeChestTreeTableContextMenu.
	
	self makeExpandableLayouts.

	self layout: self defaultLayout
]

{ #category : 'initialization' }
ChestPresenter >> initializeWindow: aWindowPresenter [

	chestTableWithContent initializeWindow: aWindowPresenter.
	super initializeWindow: aWindowPresenter
]

{ #category : 'loading' }
ChestPresenter >> loadBindingsFromAllChestsInPlayground [

	^ self addBindingsInPlayground: self collectBindingsFromAllChests
]

{ #category : 'loading' }
ChestPresenter >> loadBindingsFromSelectedChestInPlayground [

	^ self addBindingsInPlayground:
		  (self collectBindingsFromChest: self selectedChest)
]

{ #category : 'adding' }
ChestPresenter >> loadSelectedItemBindingInPlayground [

	self addBindingsInPlayground:
		{ (self convertBindingIntoProperWorkspaceVariable: self selectedItem) }
]

{ #category : 'presenter building' }
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

{ #category : 'presenter building' }
ChestPresenter >> makeChestContentsTable [

	self makeChestContentTableContextMenu.
	^ chestContentsTable
		  whenSelectionChangedDo: [ :selection |
			  chestTableWithContent chestContentsTableTransmitBlock cull:
					  selection.
			  inspector model inspectedObject:
					  (selection selectedItem ifNotNil: [ :association |
							   association value ]).
			  inspector updateList ];
		  applyKeyBindingsFromMenu: chestContentsTable contextMenu value;
		  yourself
]

{ #category : 'presenter building' }
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

{ #category : 'presenter building' }
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

{ #category : 'presenter building' }
ChestPresenter >> makeChestsTable [

	self makeChestTableContextMenu.
	^ chestsTable
		  applyKeyBindingsFromMenu: chestsTable contextMenu value;
		  yourself
]

{ #category : 'layout' }
ChestPresenter >> makeExpandableLayouts [

	showPlaygroundButton := self newToggleButton
		                        state: self class showPlayground;
		                        icon: (self application iconNamed: #disable);
		                        yourself.
	showPlaygroundContainer := SpBoxLayout newVertical
		                           add: #chestTableWithContent;
		                           add: showPlaygroundButton expand: false;
		                           yourself.

	self class showPlayground ifTrue: [ self displayPlayground ].

	showInspectorButton := self newToggleButton
		                       state: self class showInspector;
		                       icon: (self application iconNamed: #disable);
		                       yourself.

	self class showInspector
		ifTrue: [ self displayInspector ]
		ifFalse: [ self hideInspector ].

	showPlaygroundButton
		whenActivatedDo: [
			self class showPlayground: true.
			self displayPlayground ];
		whenDeactivatedDo: [
			self class showPlayground: false.
			self hidePlayground.
			"not satisfied with this but, for obscure reasons, the layout won't update automatically if wer hide the playground after displaying or hiding the inspector. It still displays automatically the playground though, leading to having several playgrounds. I need to force the layout update to prevent that, though I don't really understand why I need to do that. Probably a Spec bug"
			self layout: globalContainer ].

	showInspectorButton
		whenActivatedDo: [
			self class showInspector: true.
			self displayInspector.
			self layout: globalContainer ];
		whenDeactivatedDo: [
			self class showInspector: false.
			self hideInspector.
			self layout: globalContainer ]
]

{ #category : 'presenter building' }
ChestPresenter >> makePlayground [

	| newPlayground |
	newPlayground := StPlaygroundPresenter new.

	debugger ifNotNil: [
		newPlayground firstPage text interactionModel:
			(ChestCodeScriptingInteractionModel debugger: debugger) ].
	newPlayground firstPage text text:
		'tata := Chest at: ''fortyTwo'' "access an object from the default chest".
(Chest named: ''ExampleChest'') at: ''tata'' put: #tata "error: an object is already named ''tata'' in this chest".
Chest inChest: ''ExampleChest'' at: ''tata'' put: #tata "error: an object is already named ''tata'' in this chest. If ''ExampleChest'' didn''t exist, it would create it".
Chest weak newNamed: ''WeakChestExample'' "creates a new chest that holds weak references to its stored objects"'.

	^ newPlayground
]

{ #category : 'removing' }
ChestPresenter >> removeAllChests [

	chestTableWithContent removeAllChests
]

{ #category : 'removing' }
ChestPresenter >> removeAllItemsFromSelectedChest [

	chestTableWithContent removeAllItemsFromSelectedChest
]

{ #category : 'removing' }
ChestPresenter >> removeSelectedChest [

	chestTableWithContent removeSelectedChest
]

{ #category : 'removing' }
ChestPresenter >> removeSelectedItem [

	chestTableWithContent removeSelectedItem
]

{ #category : 'renaming' }
ChestPresenter >> renameSelectedChest [

	^ chestTableWithContent renameSelectedChest
]

{ #category : 'renaming' }
ChestPresenter >> renameSelectedItem [

	^ chestTableWithContent renameSelectedItem
]

{ #category : 'ui - dialogs' }
ChestPresenter >> requestExpressionToStoreInChest [

	chestTableWithContent requestExpressionToStoreInChest
]

{ #category : 'ui - dialogs' }
ChestPresenter >> requestNameNewChest [

	chestTableWithContent requestNameNewChest
]

{ #category : 'accessing' }
ChestPresenter >> selectedChest [

	^ chestTableWithContent selectedChest
]

{ #category : 'accessing' }
ChestPresenter >> selectedItem [

	^ chestTableWithContent selectedItem
]

{ #category : 'initialization' }
ChestPresenter >> setModelBeforeInitialization: aStDebugger [

	debugger := aStDebugger
]

{ #category : 'specs' }
ChestPresenter >> title [

	^ 'Chests'
]
