Class {
	#name : #ChestCommand,
	#superclass : #CmCommand,
	#category : #'Chest-Commands'
}

{ #category : #'accessing - commands classes' }
ChestCommand class >> chestCodePresenterCommandClasses [

	^ { ChestLoadObjectIntoCode }
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

	^ {  }
]

{ #category : #'accessing - commands classes' }
ChestCommand class >> chestTreeTableToolbarCommandClasses [

	^ { 
		  ChestAddNewChestCommand.
		  ChestRemoveAllChestsCommand }
]
