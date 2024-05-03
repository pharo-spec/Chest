Class {
	#name : 'ClipboardChestTest',
	#superclass : 'WeakChestTest',
	#category : 'Chest-Tests',
	#package : 'Chest-Tests'
}

{ #category : 'tests' }
ClipboardChestTest >> chestClass [

	^ ClipboardChest
]

{ #category : 'tests' }
ClipboardChestTest >> testAddObjectToClipboard [

	| chest |
	chest := self chestClass new.
	chest at: 'v1' put: 1.
	self assertCollection: chest lastClipboardKeys equals: #( 'v1' ).
	self assert: (chest at: 'v1') equals: 1.
	self assert: chest currentSize equals: 1.

	chest at: 'v2' put: 2.
	self assertCollection: chest lastClipboardKeys equals: #( 'v1' 'v2' ).
	self assert: (chest at: 'v1') equals: 1.
	self assert: (chest at: 'v2') equals: 2.
	self assert: chest currentSize equals: 2.

	chest at: 'v3' put: 3.
	self
		assertCollection: chest lastClipboardKeys
		equals: #( 'v1' 'v2' 'v3' ).
	self assert: (chest at: 'v1') equals: 1.
	self assert: (chest at: 'v2') equals: 2.
	self assert: (chest at: 'v3') equals: 3.
	self assert: chest currentSize equals: 3
]

{ #category : 'tests' }
ClipboardChestTest >> testAddObjectToClipboardWhenClipboardIsFull [

	| chest |
	chest := self chestClass new
		         maxSize: 3;
		         yourself.
	chest at: 'v1' put: 1.
	chest at: 'v2' put: 2.
	chest at: 'v3' put: 3.

	self assert: chest currentSize equals: 3.
	self
		assertCollection: chest lastClipboardKeys
		equals: #( 'v1' 'v2' 'v3' ).
	self assert: (chest at: 'v1') equals: 1.
	self assert: (chest at: 'v2') equals: 2.
	self assert: (chest at: 'v3') equals: 3.


	chest at: 'v4' put: 4.

	self assert: chest currentSize equals: 3.
	self
		assertCollection: chest lastClipboardKeys
		equals: #( 'v2' 'v3' 'v4' ).
	self assert: (chest at: 'v4') equals: 4.
	self assert: (chest at: 'v2') equals: 2.
	self assert: (chest at: 'v3') equals: 3.

	self should: [ chest at: 'v1' ] raise: KeyNotFound
]

{ #category : 'tests' }
ClipboardChestTest >> testAddObjectToClipboardWhenClipboardIsFullAndKeyAlreadyExists [

	| chest |
	chest := self chestClass new
		         maxSize: 3;
		         yourself.
	chest at: 'v1' put: 1.
	chest at: 'v2' put: 2.
	chest at: 'v3' put: 3.

	self assert: chest currentSize equals: 3.
	self
		assertCollection: chest lastClipboardKeys
		equals: #( 'v1' 'v2' 'v3' ).
	self assert: (chest at: 'v1') equals: 1.
	self assert: (chest at: 'v2') equals: 2.
	self assert: (chest at: 'v3') equals: 3.


	self
		should: [ chest at: 'v2' put: 4 ]
		raise: ChestKeyAlreadyInUseError.

	self assert: chest currentSize equals: 3.
	self
		assertCollection: chest lastClipboardKeys
		equals: #( 'v1' 'v2' 'v3' ).
	self assert: (chest at: 'v1') equals: 1.
	self assert: (chest at: 'v2') equals: 2.
	self assert: (chest at: 'v3') equals: 3
]

{ #category : 'tests' }
ClipboardChestTest >> testAddObjectToClipboardWhenClipboardIsFullAndObjectAlreadyExists [

	| chest |
	chest := self chestClass new
		         maxSize: 3;
		         yourself.
	chest at: 'v1' put: 1.
	chest at: 'v2' put: 2.
	chest at: 'v3' put: 3.

	self assert: chest currentSize equals: 3.
	self
		assertCollection: chest lastClipboardKeys
		equals: #( 'v1' 'v2' 'v3' ).
	self assert: (chest at: 'v1') equals: 1.
	self assert: (chest at: 'v2') equals: 2.
	self assert: (chest at: 'v3') equals: 3.


	chest at: 'v4' put: 2.

	self assert: chest currentSize equals: 3.
	self
		assertCollection: chest lastClipboardKeys
		equals: #( 'v1' 'v3' 'v4' ).
	self assert: (chest at: 'v1') equals: 1.
	self assert: (chest at: 'v4') equals: 2.
	self assert: (chest at: 'v3') equals: 3.

	self should: [ chest at: 'v2' ] raise: KeyNotFound
]

{ #category : 'tests' }
ClipboardChestTest >> testClipboardDefaultInstance [

	self assert: (self chestClass defaultInstance isKindOf: self chestClass)
]

{ #category : 'tests' }
ClipboardChestTest >> testClipboardInitialize [

	| chest |
	chest := self chestClass new.
	self assert: chest maxSize equals: 10.
	self assert: chest contents size equals: 0.
	self assertEmpty: chest lastClipboardKeys.
	self assert: chest currentSize equals: 0
]

{ #category : 'tests' }
ClipboardChestTest >> testMaxSizeWhenChestIsExpanded [

	| chest |
	chest := self chestClass new
		         maxSize: 5;
		         yourself.
	chest at: 'v1' put: 1.
	chest at: 'v2' put: 2.
	chest at: 'v3' put: 3.
	chest at: 'v4' put: 4.
	chest at: 'v5' put: 5.

	self assert: chest maxSize equals: 5.
	self assert: chest currentSize equals: 5.
	self
		assertCollection: chest lastClipboardKeys
		equals: #( 'v1' 'v2' 'v3' 'v4' 'v5' ).
	self assert: (chest at: 'v1') equals: 1.
	self assert: (chest at: 'v2') equals: 2.
	self assert: (chest at: 'v3') equals: 3.
	self assert: (chest at: 'v4') equals: 4.
	self assert: (chest at: 'v5') equals: 5.

	chest maxSize: 10.

	self assert: chest maxSize equals: 10.
	self assert: chest currentSize equals: 5.
	self
		assertCollection: chest lastClipboardKeys
		equals: #( 'v1' 'v2' 'v3' 'v4' 'v5' ).
	self assert: (chest at: 'v1') equals: 1.
	self assert: (chest at: 'v2') equals: 2.
	self assert: (chest at: 'v3') equals: 3.
	self assert: (chest at: 'v4') equals: 4.
	self assert: (chest at: 'v5') equals: 5
]

{ #category : 'tests' }
ClipboardChestTest >> testMaxSizeWhenChestIsShrunk [

	| chest |
	chest := self chestClass new
		         maxSize: 5;
		         yourself.
	chest at: 'v1' put: 1.
	chest at: 'v2' put: 2.
	chest at: 'v3' put: 3.
	chest at: 'v4' put: 4.
	chest at: 'v5' put: 5.

	self assert: chest maxSize equals: 5.
	self assert: chest currentSize equals: 5.
	self
		assertCollection: chest lastClipboardKeys
		equals: #( 'v1' 'v2' 'v3' 'v4' 'v5' ).
	self assert: (chest at: 'v1') equals: 1.
	self assert: (chest at: 'v2') equals: 2.
	self assert: (chest at: 'v3') equals: 3.
	self assert: (chest at: 'v4') equals: 4.
	self assert: (chest at: 'v5') equals: 5.

	chest maxSize: 3.

	self assert: chest maxSize equals: 3.
	self assert: chest currentSize equals: 3.
	self
		assertCollection: chest lastClipboardKeys
		equals: #( 'v3' 'v4' 'v5' ).
	self assert: (chest at: 'v3') equals: 3.
	self assert: (chest at: 'v4') equals: 4.
	self assert: (chest at: 'v5') equals: 5.
	self should: [ chest at: 'v1' ] raise: KeyNotFound.
	self should: [ chest at: 'v2' ] raise: KeyNotFound
]

{ #category : 'tests' }
ClipboardChestTest >> testRemoveFirstClipboardEntry [

	| chest |
	chest := self chestClass new
		         maxSize: 3;
		         yourself.
	chest at: 'v1' put: 1.
	chest at: 'v2' put: 2.
	chest at: 'v3' put: 3.

	self assert: chest currentSize equals: 3.
	self
		assertCollection: chest lastClipboardKeys
		equals: #( 'v1' 'v2' 'v3' ).
	self assert: (chest at: 'v1') equals: 1.
	self assert: (chest at: 'v2') equals: 2.
	self assert: (chest at: 'v3') equals: 3.


	chest removeFirstClipboardEntry.

	self assert: chest currentSize equals: 2.
	self assertCollection: chest lastClipboardKeys equals: #( 'v2' 'v3' ).
	self assert: (chest at: 'v2') equals: 2.
	self assert: (chest at: 'v3') equals: 3.
	self should: [ chest at: 'v1' ] raise: KeyNotFound.

	chest removeFirstClipboardEntry.

	self assert: chest currentSize equals: 1.
	self assertCollection: chest lastClipboardKeys equals: #( 'v3' ).
	self assert: (chest at: 'v3') equals: 3.
	self should: [ chest at: 'v1' ] raise: KeyNotFound.
	self should: [ chest at: 'v2' ] raise: KeyNotFound.

	chest removeFirstClipboardEntry.

	self assert: chest currentSize equals: 0.
	self assertCollection: chest lastClipboardKeys equals: #(  ).
	self should: [ chest at: 'v1' ] raise: KeyNotFound.
	self should: [ chest at: 'v2' ] raise: KeyNotFound.
	self should: [ chest at: 'v2' ] raise: KeyNotFound
]

{ #category : 'tests' }
ClipboardChestTest >> testRemoveFirstClipboardEntryWhenListIsEmpty [

	| chest |
	chest := self chestClass new
		         maxSize: 3;
		         yourself.

	self assert: chest currentSize equals: 0.
	self assertCollection: chest lastClipboardKeys equals: #(  ).

	self
		should: [ chest removeFirstClipboardEntry ]
		raise: ObjectNotInChestError
]
