Class {
	#name : #ChestRemoveChestCommand,
	#superclass : #ChestCommand,
	#category : #'Chest-Commands'
}

{ #category : #default }
ChestRemoveChestCommand class >> defaultDescription [

	^ 'Remove selected chest'
]

{ #category : #default }
ChestRemoveChestCommand class >> defaultIconName [

	^ #remotesManagerRemoveRemote
]

{ #category : #default }
ChestRemoveChestCommand class >> defaultName [

	^ 'Remove chest'
]

{ #category : #default }
ChestRemoveChestCommand class >> defaultShortcutKey [

	^ $c meta , $r meta , $m meta
]

{ #category : #testing }
ChestRemoveChestCommand >> canBeExecuted [

	^ context selectedChest isNotNil
]

{ #category : #executing }
ChestRemoveChestCommand >> execute [

	^ context removeSelectedChest
]
