Extension { #name : #Variable }

{ #category : #'*Chest-Commands' }
Variable >> comesFromChest [

	^ self propertyAt: #comesFromChest ifAbsent: [ false ]
]
