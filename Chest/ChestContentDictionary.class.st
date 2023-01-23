"
Dictionary used by Chest that contains `(key, value, variable name)` triplets, variable name being the name of the variable when the association will be loaded into a playground or a debugger.
"
Class {
	#name : #ChestContentDictionary,
	#superclass : #Dictionary,
	#category : #Chest
}

{ #category : #accessing }
ChestContentDictionary class >> associationClass [

	^ ChestAssociation
]

{ #category : #accessing }
ChestContentDictionary >> associationClass [

	^ self class associationClass
]

{ #category : #accessing }
ChestContentDictionary >> at: key put: anObject [

	"Set the value at key to be anObject.  If key is not found, create a
	new entry for key and set is value to anObject. Answer anObject."

	| index assoc |
	index := self findElementOrNil: key.
	assoc := array at: index.
	assoc
		ifNil: [ 
			self
				atNewIndex: index
				put: (self associationClass key: key value: anObject variableName: key) ]
		ifNotNil: [ assoc value: anObject ].
	^ anObject
]
