Class {
	#name : #ChestInspectItemCommand,
	#superclass : #ChestCommand,
	#category : #'Chest-Commands'
}

{ #category : #default }
ChestInspectItemCommand class >> defaultDescription [

	^ 'Inspect the object'
]

{ #category : #default }
ChestInspectItemCommand class >> defaultName [

	^ 'Inspect item'
]

{ #category : #default }
ChestInspectItemCommand class >> defaultShortcutKey [

	^ $i meta
]

{ #category : #testing }
ChestInspectItemCommand >> canBeExecuted [

	^ context selectedItem isNotNil
]

{ #category : #executing }
ChestInspectItemCommand >> execute [ 

	^ context selectedItem value inspect
]
