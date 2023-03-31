Class {
	#name : #ChestRemoveItemCommand,
	#superclass : #ChestCommand,
	#category : #'Chest-Commands'
}

{ #category : #default }
ChestRemoveItemCommand class >> defaultDescription [

	^ 'Remove the selected object from the selected chest'
]

{ #category : #default }
ChestRemoveItemCommand class >> defaultIconName [ 

	^ #remotesManagerRemoveRemote
]

{ #category : #default }
ChestRemoveItemCommand class >> defaultName [ 

	^ 'Remove item'
]

{ #category : #default }
ChestRemoveItemCommand class >> defaultShortcutKey [

	^ $r meta , $m meta
]

{ #category : #testing }
ChestRemoveItemCommand >> canBeExecuted [

	^ context selectedItem isNotNil
]

{ #category : #executing }
ChestRemoveItemCommand >> execute [

	^ context removeSelectedItem
]
