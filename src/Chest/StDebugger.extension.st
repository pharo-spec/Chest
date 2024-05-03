Extension { #name : 'StDebugger' }

{ #category : '*Chest' }
StDebugger >> bindings [

	^ self interactionModel bindings
]

{ #category : '*Chest' }
StDebugger >> interactionModel [

	^ self code interactionModel
]
