Class {
	#name : 'ChestInspectChestCommand',
	#superclass : 'ChestCommand',
	#category : 'Chest-Commands',
	#package : 'Chest-Commands'
}

{ #category : 'default' }
ChestInspectChestCommand class >> defaultDescription [

	^ 'Inspect the chest'
]

{ #category : 'default' }
ChestInspectChestCommand class >> defaultIconName [

	^ #glamorousInspect
]

{ #category : 'default' }
ChestInspectChestCommand class >> defaultName [

	^ 'Inspect chest'
]

{ #category : 'default' }
ChestInspectChestCommand class >> defaultShortcutKey [

	^ $i meta
]

{ #category : 'testing' }
ChestInspectChestCommand >> canBeExecuted [

	^ context selectedChest isNotNil
]

{ #category : 'executing' }
ChestInspectChestCommand >> execute [

	context selectedChest inspect
]
