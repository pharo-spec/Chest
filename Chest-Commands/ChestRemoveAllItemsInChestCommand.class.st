Class {
	#name : #ChestRemoveAllItemsInChestCommand,
	#superclass : #ChestCommand,
	#category : #'Chest-Commands'
}

{ #category : #default }
ChestRemoveAllItemsInChestCommand class >> defaultDescription [

	^ 'Remove all objects from the selected chest'
]

{ #category : #default }
ChestRemoveAllItemsInChestCommand class >> defaultIconName [

	^ #glamorousTrash
]

{ #category : #default }
ChestRemoveAllItemsInChestCommand class >> defaultName [

	^ 'Remove all items in chest'
]

{ #category : #default }
ChestRemoveAllItemsInChestCommand class >> defaultShortcutKey [ 

	^  $r meta , $m meta shift
]

{ #category : #testing }
ChestRemoveAllItemsInChestCommand >> canBeExecuted [

	^ context selectedChest isNotNil
]

{ #category : #executing }
ChestRemoveAllItemsInChestCommand >> execute [

	^ context removeAllItemsFromSelectedChest 
]
