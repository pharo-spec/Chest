Extension { #name : #Association }

{ #category : #'*Chest' }
Association >> chestChildren [

	^ {  } asOrderedCollection
]

{ #category : #'*Chest' }
Association >> chestEvaluation [

	^ self value
]

{ #category : #'*Chest' }
Association class >> chestIcon [ 


	^ Smalltalk ui icons iconNamed: 'objects'
]

{ #category : #'*Chest' }
Association >> chestName [

	^ self key
]
