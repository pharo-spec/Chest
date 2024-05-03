"
I am a chest that holds weakly each object I contain and that is used to temporarily copy objects from somewhere and paste them later elsewhere.
"
Class {
	#name : 'ClipboardChest',
	#superclass : 'WeakChest',

	#instVars : [
		'lastClipboardKeys',
		'maxSize',
		'currentSize'
	],
	#category : 'Chest-Model',
	#package : 'Chest',
	#tag : 'Model'
}

{ #category : 'icons' }
ClipboardChest class >> chestIcon [

	^ Smalltalk ui icons iconNamed: 'smallCopy'
]


{ #category : 'default values' }
ClipboardChest class >> defaultInstanceName [ 

	^ 'ClipboardDefault'
]

{ #category : 'class initialization' }
ClipboardChest class >> initialize [

	nextAvailableID := 1.
	defaultInstance := nil
]

{ #category : 'accessing' }
ClipboardChest class >> lastClipboardKeys [

	^ self defaultInstance lastClipboardKeys
]

{ #category : 'accessing' }
ClipboardChest class >> maxSize [

	^ self defaultInstance maxSize
]

{ #category : 'accessing' }
ClipboardChest class >> maxSize: anInteger [

	self defaultInstance maxSize: anInteger
]

{ #category : 'removing' }
ClipboardChest class >> removeFirstClipboardEntry [

	self defaultInstance removeFirstClipboardEntry
]

{ #category : 'accessing' }
ClipboardChest >> at: aString put: anObject [

	| result |
	result := super at: aString put: anObject.
	lastClipboardKeys add: aString.
	currentSize = maxSize ifTrue: [ self removeFirstClipboardEntry ].
	currentSize := currentSize + 1.
	^ result
]

{ #category : 'initialization' }
ClipboardChest >> initializeContents [

	super initializeContents.
	lastClipboardKeys := LinkedList new.
	currentSize := 0
]

{ #category : 'accessing' }
ClipboardChest >> lastClipboardKeys [

	^ lastClipboardKeys copy 
]

{ #category : 'accessing' }
ClipboardChest >> maxSize [

	^ maxSize ifNil: [ maxSize := 10 ]
]

{ #category : 'accessing' }
ClipboardChest >> maxSize: anInteger [

	maxSize := anInteger.
	1 to: currentSize - maxSize do: [ :i |
	self removeFirstClipboardEntry ]
]

{ #category : 'removing' }
ClipboardChest >> removeFirstClipboardEntry [

	| firstKey |
	firstKey := [ lastClipboardKeys first ]
		            on: CollectionIsEmpty
		            do: [ "If the collection is empty, the next call will raise a proper exception for Chest"
			            nil ].
	self removeObjectNamed: firstKey
]

{ #category : 'accessing' }
ClipboardChest >> removeKeySilently: aKey [

	super removeKeySilently: aKey.
	lastClipboardKeys remove: aKey.
	currentSize := currentSize - 1
]
