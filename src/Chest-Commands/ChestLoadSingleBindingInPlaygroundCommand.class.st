Class {
	#name : #ChestLoadSingleBindingInPlaygroundCommand,
	#superclass : #ChestCommand,
	#category : #'Chest-Commands'
}

{ #category : #default }
ChestLoadSingleBindingInPlaygroundCommand class >> defaultDescription [ 

	^ 'Load the selected object into the playground, in a variable of same name as its key in the chest.'
]

{ #category : #default }
ChestLoadSingleBindingInPlaygroundCommand class >> defaultName [ 

	^ 'Load item'
]

{ #category : #default }
ChestLoadSingleBindingInPlaygroundCommand class >> defaultShortcutKey [

	^ $l meta
]

{ #category : #testing }
ChestLoadSingleBindingInPlaygroundCommand >> canBeExecuted [

	^ context selectedItem isNotNil
]

{ #category : #executing }
ChestLoadSingleBindingInPlaygroundCommand >> execute [

	^ context loadSelectedItemBindingInPlayground
]
