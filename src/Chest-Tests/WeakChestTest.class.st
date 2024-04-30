Class {
	#name : 'WeakChestTest',
	#superclass : 'ChestTest',
	#category : 'Chest-Tests',
	#package : 'Chest-Tests'
}

{ #category : 'tests' }
WeakChestTest >> chestClass [

	^ WeakChest
]

{ #category : 'tests' }
WeakChestTest >> testAddObjectToWeakChest [

	| chest object |
	chest := WeakChest new.
	object := Object new.

	chest at: 'toto' put: object.

	self assert: (chest at: 'toto') identicalTo: object.

	object := nil.
	Smalltalk garbageCollect.

	self assert: (chest at: 'toto') equals: nil
]

{ #category : 'tests' }
WeakChestTest >> testWeakDefaultInstance [

	self assert: (WeakChest defaultInstance isKindOf: WeakChest)
]
