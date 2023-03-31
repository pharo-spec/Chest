Class {
	#name : #ChestRenameItemCommand,
	#superclass : #ChestCommand,
	#category : #'Chest-Commands'
}

{ #category : #default }
ChestRenameItemCommand class >> defaultDescription [

	^ 'Rename the selected item in chest'
]

{ #category : #default }
ChestRenameItemCommand class >> defaultName [

	^ 'Rename item'
]

{ #category : #default }
ChestRenameItemCommand class >> defaultShortcutKey [

	^ $r meta shift
]

{ #category : #testing }
ChestRenameItemCommand >> canBeExecuted [

	^ context selectedItem isNotNil
]

{ #category : #executing }
ChestRenameItemCommand >> execute [

	^ context renameSelectedItem
]
