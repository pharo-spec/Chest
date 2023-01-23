"
I am a chest that holds weakly each object I contain.
"
Class {
	#name : #WeakChest,
	#superclass : #Chest,
	#category : #Chest
}

{ #category : #accessing }
WeakChest class >> defaultInstance [

	^ defaultInstance ifNil: [ 
		  defaultInstance := self newNamed: self defaultInstanceName ]
]

{ #category : #'default values' }
WeakChest class >> defaultInstanceName [

	^ 'WDefault'
]

{ #category : #'default values' }
WeakChest class >> defaultNameForNewChest [

	^ 'WChest_'
]

{ #category : #initialization }
WeakChest class >> initialize [

	nextAvailableID := 1.
	defaultInstance := nil
]

{ #category : #initialization }
WeakChest >> initializeContents [

	contents := WeakChestContentDictionary new
]