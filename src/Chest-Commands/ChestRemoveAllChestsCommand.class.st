Class {
	#name : 'ChestRemoveAllChestsCommand',
	#superclass : 'ChestCommand',
	#category : 'Chest-Commands',
	#package : 'Chest-Commands'
}

{ #category : 'default' }
ChestRemoveAllChestsCommand class >> defaultDescription [

	^ 'Remove all chests'
]

{ #category : 'default' }
ChestRemoveAllChestsCommand class >> defaultIconName [ 

	^ #glamorousTrash
]

{ #category : 'default' }
ChestRemoveAllChestsCommand class >> defaultName [ 

	^ 'Remove all chests'
]

{ #category : 'executing' }
ChestRemoveAllChestsCommand >> execute [

	^ context removeAllChests
]
