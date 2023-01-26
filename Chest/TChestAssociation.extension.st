Extension { #name : #TChestAssociation }

{ #category : #'*Chest' }
TChestAssociation >> chestChildren [

	^ {  } asOrderedCollection
]

{ #category : #'*Chest' }
TChestAssociation >> chestEvaluation [

	^ self value
]

{ #category : #'*Chest' }
TChestAssociation >> chestName [

	^ self key
]
