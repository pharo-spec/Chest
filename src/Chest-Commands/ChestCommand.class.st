"
Abstract class whose subclasses are all commands for `Chest`. It is also an utility class that provides on class side groups of commands that can be used to create Commander command groups.
"
Class {
	#name : #ChestCommand,
	#superclass : #CmCommand,
	#category : #'Chest-Commands'
}

{ #category : #'accessing - commands classes' }
ChestCommand class >> chestCodePresenterCommandClasses [

	^ { ChestLoadObjectIntoCodeCommand }
]

{ #category : #'accessing - commands classes' }
ChestCommand class >> chestLoadChestCommandClasses [

	^ { 
		  ChestLoadBindingsInPlaygroundCommand.
		  ChestLoadBindingsFromAllChestsInPlaygroundCommand }
]

{ #category : #'accessing - commands classes' }
ChestCommand class >> chestLoadItemCommandClasses [

	^ { ChestLoadSingleBindingInPlaygroundCommand }
]

{ #category : #'accessing - commands classes' }
ChestCommand class >> chestTableContentMenuCommandClasses [

	^ { 
		  ChestRenameItemCommand.
		  ChestInspectItemCommand.
		  ChestRemoveItemCommand.
		  ChestRemoveAllItemsInChestCommand }
]

{ #category : #'accessing - commands classes' }
ChestCommand class >> chestTableContentToolbarCommandClasses [

	^ { 
		  ChestRemoveItemCommand.
		  ChestRemoveAllItemsInChestCommand }
]

{ #category : #'accessing - commands classes' }
ChestCommand class >> chestTableMenuCommandClasses [

	^ { 
		  ChestRenameChestCommand.
		  ChestRemoveChestCommand.
		  ChestRemoveAllChestsCommand }
]

{ #category : #'accessing - commands classes' }
ChestCommand class >> chestTableToolbarCommandClasses [

	^ { 
		  ChestAddNewChestCommand.
		  ChestRemoveChestCommand.
		  ChestRemoveAllChestsCommand }
]

{ #category : #'accessing - commands classes' }
ChestCommand class >> chestTreeTableMenuCommandClasses [

	^ self chestTableMenuCommandClasses
	  , self chestTableContentMenuCommandClasses
]

{ #category : #'accessing - commands classes' }
ChestCommand class >> chestTreeTableToolbarCommandClasses [

	^ { 
		  ChestAddNewChestCommand.
		  ChestRemoveAllChestsCommand }
]

{ #category : #default }
ChestCommand class >> defaultIconName [

	^ nil
]

{ #category : #default }
ChestCommand class >> defaultShortcutKey [

	^ nil
]

{ #category : #default }
ChestCommand class >> isVisibleForContext: aSpecContext [

	^ true
]
