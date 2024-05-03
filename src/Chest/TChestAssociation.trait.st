"
I'm a trait allowing associations to hold a variable name for a key-value association in chests, to be able to load objects into contexts with a different variable name than its key in the chest.
"
Trait {
	#name : 'TChestAssociation',
	#instVars : [
		'variableName'
	],
	#category : 'Chest-Model',
	#package : 'Chest',
	#tag : 'Model'
}

{ #category : 'icons' }
TChestAssociation classSide >> chestIcon [ 


	^ Smalltalk ui icons iconNamed: 'objects'
]

{ #category : 'instance creation' }
TChestAssociation classSide >> key: key value: value variableName: variableName [

	^ self new
		  key: key;
		  value: value;
		  variableName: variableName
]

{ #category : 'accessing' }
TChestAssociation >> chestChildren [

	^ {  } asOrderedCollection
]

{ #category : 'accessing' }
TChestAssociation >> chestEvaluation [

	^ self value
]

{ #category : 'accessing' }
TChestAssociation >> chestName [

	^ self key
]

{ #category : 'accessing' }
TChestAssociation >> variableName [

	^ variableName
]

{ #category : 'accessing' }
TChestAssociation >> variableName: aString [

	Chest checkValidName: aString.
	variableName := aString
]
