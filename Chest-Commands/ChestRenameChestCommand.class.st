Class {
	#name : #ChestRenameChestCommand,
	#superclass : #ChestCommand,
	#category : #'Chest-Commands'
}

{ #category : #default }
ChestRenameChestCommand class >> defaultDescription [

	^ 'Rename the selected chest'
]

{ #category : #default }
ChestRenameChestCommand class >> defaultName [

	^ 'Rename chest'
]

{ #category : #default }
ChestRenameChestCommand class >> defaultShortcutKey [ 

	^ $r meta
]

{ #category : #testing }
ChestRenameChestCommand >> canBeExecuted [

	^ context selectedChest isNotNil
]

{ #category : #executing }
ChestRenameChestCommand >> execute [

	^ context renameSelectedChest
]
