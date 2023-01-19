Class {
	#name : #ChestRemoveAllChestsCommand,
	#superclass : #ChestCommand,
	#category : #'Chest-Commands'
}

{ #category : #default }
ChestRemoveAllChestsCommand class >> defaultDescription [

	^ 'Remove all chests'
]

{ #category : #default }
ChestRemoveAllChestsCommand class >> defaultIconName [ 

	^ #glamorousTrash
]

{ #category : #default }
ChestRemoveAllChestsCommand class >> defaultName [ 

	^ 'Remove all chests'
]

{ #category : #default }
ChestRemoveAllChestsCommand class >> defaultShortcutKey [

	^ $c meta , $r meta , $m meta shift
]

{ #category : #executing }
ChestRemoveAllChestsCommand >> execute [

	^ context removeAllChests
]
