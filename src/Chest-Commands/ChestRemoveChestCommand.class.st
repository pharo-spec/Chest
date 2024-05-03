Class {
	#name : 'ChestRemoveChestCommand',
	#superclass : 'ChestCommand',
	#category : 'Chest-Commands',
	#package : 'Chest-Commands'
}

{ #category : 'default' }
ChestRemoveChestCommand class >> defaultDescription [

	^ 'Remove selected chest'
]

{ #category : 'default' }
ChestRemoveChestCommand class >> defaultIconName [

	^ #remotesManagerRemoveRemote
]

{ #category : 'default' }
ChestRemoveChestCommand class >> defaultName [

	^ 'Remove chest'
]

{ #category : 'testing' }
ChestRemoveChestCommand >> canBeExecuted [

	^ context selectedChest isNotNil
]

{ #category : 'executing' }
ChestRemoveChestCommand >> execute [

	^ context removeSelectedChest
]
