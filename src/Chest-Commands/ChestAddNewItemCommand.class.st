Class {
	#name : #ChestAddNewItemCommand,
	#superclass : #ChestCommand,
	#category : #'Chest-Commands'
}

{ #category : #default }
ChestAddNewItemCommand class >> defaultDescription [

	^ 'Request an expression whose result will be stored inside the selected chest'
]

{ #category : #default }
ChestAddNewItemCommand class >> defaultIconName [

	^ #add
]

{ #category : #default }
ChestAddNewItemCommand class >> defaultName [

	^ 'Add item'
]

{ #category : #testing }
ChestAddNewItemCommand >> canBeExecuted [

	^ context selectedChest isNotNil
]

{ #category : #executing }
ChestAddNewItemCommand >> execute [

	^ context requestExpressionToStoreInChest
]
