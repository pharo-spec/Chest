"
Association used by `ChestContentDictionary` that, when its value will be loaded into a playground or a debugger, can have a variable name that is different from its key in the dictionary.
"
Class {
	#name : #ChestAssociation,
	#superclass : #Association,
	#instVars : [
		'variableName'
	],
	#category : #Chest
}

{ #category : #'as yet unclassified' }
ChestAssociation class >> key: key value: value variableName: variableName [

	^ self new
		  key: key;
		  value: value;
		  variableName: variableName
]

{ #category : #accessing }
ChestAssociation >> variableName [

	^ variableName
]

{ #category : #accessing }
ChestAssociation >> variableName: aString [

	Chest checkValidName: aString.
	variableName := aString
]
