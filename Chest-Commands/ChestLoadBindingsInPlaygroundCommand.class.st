Class {
	#name : #ChestLoadBindingsInPlaygroundCommand,
	#superclass : #ChestCommand,
	#category : #'Chest-Commands'
}

{ #category : #default }
ChestLoadBindingsInPlaygroundCommand class >> defaultDescription [

	^ 'Load all objects from the selected chest into the context''s playground, in variables of same name as their key in the chest'
]

{ #category : #default }
ChestLoadBindingsInPlaygroundCommand class >> defaultName [

	^ 'Load'
]

{ #category : #'accessing - defaults' }
ChestLoadBindingsInPlaygroundCommand class >> defaultShortcutKey [ 

	^ $l meta
]

{ #category : #testing }
ChestLoadBindingsInPlaygroundCommand >> canExecute [

	^ context selectedChest isNotNil
]

{ #category : #executing }
ChestLoadBindingsInPlaygroundCommand >> execute [

	^ context loadBindingsFromSelectedChestInPlayground
]
