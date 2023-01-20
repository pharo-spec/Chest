Class {
	#name : #ChestLoadBindingsFromAllChestsInPlaygroundCommand,
	#superclass : #ChestCommand,
	#category : #'Chest-Commands'
}

{ #category : #default }
ChestLoadBindingsFromAllChestsInPlaygroundCommand class >> defaultDescription [

	^ 'Load all objects from all chests into the playground, in variables of same name as their key in their respective chest'
]

{ #category : #default }
ChestLoadBindingsFromAllChestsInPlaygroundCommand class >> defaultName [

	^ 'Load all chests'' bindings'
]

{ #category : #'accessing - defaults' }
ChestLoadBindingsFromAllChestsInPlaygroundCommand class >> defaultShortcutKey [

	^ $l shift meta
]

{ #category : #executing }
ChestLoadBindingsFromAllChestsInPlaygroundCommand >> execute [

	^ context loadBindingsFromAllChestsInPlayground
]
