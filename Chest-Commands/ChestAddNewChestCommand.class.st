Class {
	#name : #ChestAddNewChestCommand,
	#superclass : #ChestCommand,
	#category : #'Chest-Commands'
}

{ #category : #default }
ChestAddNewChestCommand class >> defaultDescription [

	^ 'Request the naming of a new chest and create it'
]

{ #category : #default }
ChestAddNewChestCommand class >> defaultIconName [

	^ #add
]

{ #category : #default }
ChestAddNewChestCommand class >> defaultName [

	^ 'add chest'
]

{ #category : #executing }
ChestAddNewChestCommand >> execute [

	^ context requestNameNewChest 
]
