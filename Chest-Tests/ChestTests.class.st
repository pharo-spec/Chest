Class {
	#name : #ChestTests,
	#superclass : #TestCase,
	#instVars : [
		'initialChests'
	],
	#category : #'Chest-Tests'
}

{ #category : #accessing }
ChestTests >> firstChestNameAvailable [

	"provides a name of a chest that doesn't already exists"

	| chestDictionary autoIncrementedNumber toto firstNameAvailable |
	chestDictionary := Chest chestDictionary.
	autoIncrementedNumber := 1.
	toto := 'toto_'.
	firstNameAvailable := toto , autoIncrementedNumber asString.
	[ chestDictionary includesKey: firstNameAvailable ] whileTrue: [ 
		autoIncrementedNumber := autoIncrementedNumber + 1.
		firstNameAvailable := toto , autoIncrementedNumber asString ].

	^ firstNameAvailable
]

{ #category : #running }
ChestTests >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	initialChests := Chest allChests copy. "Keep a copy of all the chests that currently exist"
]

{ #category : #running }
ChestTests >> tearDown [
	| nowChests |
	nowChests := Chest allChests copy.
	"Removing chests that currently exist but did not exist before the test execution"
	nowChests do: [ :aChest | (initialChests includes: aChest) ifFalse: [ Chest removeChest: aChest ] ].
]

{ #category : #tests }
ChestTests >> testAddRemoveToChest [
	self testAddRemoveToChest: Chest new.
]

{ #category : #tests }
ChestTests >> testAddRemoveToChest: aChest [
	| c o1 o2 initialChestSize o1Name o2Name |
	c := aChest.
	o1 := Object new.
	o2 := Object new.
	initialChestSize := aChest contents size.

	o1Name := c add: o1.
	o2Name := c add: o2.
	
	self assert: c contents size - initialChestSize equals: 2.
	self assert: (c at: o1Name) equals: o1.
	self assert: (c at: o2Name) equals: o2.
	c remove: o2.
	c removeObjectNamed: o1Name.
	self assert: c contents size - initialChestSize equals: 0.
	
]

{ #category : #tests }
ChestTests >> testAddRemoveToDefaultChest [
	"Tests that the Chest class itself works as a chest"
	self testAddRemoveToChest: Chest.
]

{ #category : #tests }
ChestTests >> testAddingAnObjectTwiceInSameChestWithDifferentNamesRemoveTheOldKeyForThisObject [

	| chest object oldName newName |
	chest := Chest new.
	object := Object new.
	oldName := chest add: object.

	self assert: (chest at: oldName) identicalTo: object.

	newName := chest add: object.

	self assert: (chest at: newName) identicalTo: object.
	self should: [ chest at: oldName ] raise: KeyNotFound
]

{ #category : #tests }
ChestTests >> testAlwaysGiveFreshIDToNewChests [
	| c1 c2 c3 idList c4 |
	c1 := Chest new.
	c2 := Chest new.
	c3 := Chest new.
	self assert: c1 name ~= c2 name.
	self assert: c2 name ~= c3 name.
	self assert: c1 name ~= c3 name.
	idList := OrderedCollection new.
	idList add: (c1 name); add: (c2 name); add: (c3 name).
	Chest removeChest: c3.
	c4 := Chest new.
	self assert: ((idList includes: c4 name) not).
	
	
]

{ #category : #tests }
ChestTests >> testAtPutAddsObjectToChestWithCorrectName [

	| chest object |
	chest := Chest new.
	object := 42.

	self should: [chest at: 'toto'] raise: KeyNotFound.

	chest at: 'toto' put: object.

	self assert: (chest at: 'toto') identicalTo: object
]

{ #category : #tests }
ChestTests >> testChestCreationWithCustomName [

	| firstNameAvailable chestWithCustomName |
	firstNameAvailable := self firstChestNameAvailable.

	self should: [ Chest named: firstNameAvailable ] raise: KeyNotFound.

	chestWithCustomName := Chest newNamed: firstNameAvailable.

	self assert: chestWithCustomName name equals: firstNameAvailable.
	self
		assert: (Chest named: firstNameAvailable)
		identicalTo: chestWithCustomName
]

{ #category : #tests }
ChestTests >> testChestCreationWithDefaultName [

	| chestWithDefaultName1 chestWithDefaultName2 |
	chestWithDefaultName1 := Chest new.
	chestWithDefaultName2 := Chest new.

	self
		assert: (chestWithDefaultName1 name beginsWith: 'Chest_');
		assert: (chestWithDefaultName2 name beginsWith: 'Chest_');
		assert: chestWithDefaultName1 name < chestWithDefaultName2 name.

	self
		assert: (Chest named: chestWithDefaultName1 name)
		identicalTo: chestWithDefaultName1.
	self
		assert: (Chest named: chestWithDefaultName2 name)
		identicalTo: chestWithDefaultName2
]

{ #category : #tests }
ChestTests >> testChestCreationWithNameThatAlreadyExistsRaisesAnError [

	| firstNameAvailable |
	firstNameAvailable := self firstChestNameAvailable.

	self
		shouldnt: [ Chest newNamed: firstNameAvailable ]
		raise: ChestKeyAlreadyInUseError.

	self
		should: [ Chest newNamed: firstNameAvailable ]
		raise: ChestKeyAlreadyInUseError
]

{ #category : #tests }
ChestTests >> testChestDictionaryProvidesCopyOfAllChests [

	| chestDictionary firstNameAvailable |
	chestDictionary := Chest chestDictionary.
	firstNameAvailable := self firstChestNameAvailable.

	chestDictionary at: firstNameAvailable put: 42.

	self
		should: [ Chest named: firstNameAvailable ]
		raise: KeyNotFound 
]

{ #category : #tests }
ChestTests >> testContentsProvidesCopyOfChestContent [

	| chest object contents objectInCopy |
	chest := Chest new.
	object := 42.
	objectInCopy := 72.

	chest at: 'toto' put: object.
	contents := chest contents.

	self assert: (contents at: 'toto') identicalTo: object.
	contents at: 'titi' put: objectInCopy.

	self should: [ chest at: 'titi' ] raise: KeyNotFound
]

{ #category : #tests }
ChestTests >> testDefaultInstance [
	"Tests that the default instance of the Chest class does exist"
	self assert: (Chest defaultInstance isKindOf: Chest).
]

{ #category : #tests }
ChestTests >> testEmpty [

	| chest |
	chest := Chest new.
	chest
		at: 'toto' put: 'toto';
		at: 'tata' put: 'tata';
		at: 'titi' put: 'titi'.

	self assert: (chest at: 'toto') equals: 'toto'.
	self assert: (chest at: 'tata') equals: 'tata'.
	self assert: (chest at: 'titi') equals: 'titi'.

	chest empty.

	self should: [ chest at: 'toto' ] raise: KeyNotFound.
	self should: [ chest at: 'tata' ] raise: KeyNotFound.
	self should: [ chest at: 'titi' ] raise: KeyNotFound
]

{ #category : #tests }
ChestTests >> testEmptyChest [

	| chest |
	chest := Chest new.
	chest
		at: 'toto' put: 42;
		at: 'titi' put: 72;
		at: 'tata' put: 'tata'.

	self assert: chest contents size equals: 3.

	chest empty.
	self assert: chest contents size equals: 0
]

{ #category : #tests }
ChestTests >> testGettingChestFromID [
	"Tests that retrieving chests by their id works"
	| c1 c2 |
	c1 := Chest new.
	c2 := Chest new.
	self assert: (Chest named: c1 name) identicalTo: c1.
	self assert: (Chest named: c2 name) identicalTo: c2.
	"Tests that accessing a removed chest signals an error"
	Chest removeChest: c2.
	self should: [ Chest named: c2 name ] raise: Error.
]

{ #category : #tests }
ChestTests >> testNotifications [
	"Tests that the Chest class does indeed send the notifications it is supposed to"
	| l c o |
	l := ChestEventListenerForTest new.
	l subscribeToChestAnnouncer.
	"Tests that no event has been received so far"
	self assert: l newChestReceived not.
	self assert: l contentOfChestUpdatedReceived not.
	self assert: l chestRemovedReceived not.
	
	"Test the event on chest creation"
	c := Chest new.
	self assert: l newChestReceived.
	self assert: l newChest identicalTo: c.
	
	"Test the event on chest content update"
	o := Object new.
	c add: Object new.
	self assert: l contentOfChestUpdatedReceived.
	self assert: l updatedChest identicalTo: c.
	self assert: l newContentsOfUpdatedChest equals: c contents.
	
	"Test the event on chest removal"
	Chest removeChest: c.
	self assert: l chestRemovedReceived.
	self assert: l removedChest identicalTo: c.
]

{ #category : #tests }
ChestTests >> testRemove [

	| chest |
	chest := Chest new.

	self assert: (Chest named: chest name) identicalTo: chest.

	chest remove.

	self should: [ Chest named: chest name ] raise: KeyNotFound
]

{ #category : #tests }
ChestTests >> testRemoveChestNamed [

	| chest |
	chest := Chest new.

	self assert: (Chest named: chest name) identicalTo: chest.

	Chest removeChestNamed: chest name.

	self should: [ Chest named: chest name ] raise: KeyNotFound
]

{ #category : #tests }
ChestTests >> testRemoveChestNamedWithDefaultInstance [

	| chest |
	chest := Chest defaultInstance.

	self assert: (Chest named: chest name) identicalTo: chest.

	Chest removeChestNamed: chest name.

	self assert: (Chest named: chest name) identicalTo: chest
]

{ #category : #tests }
ChestTests >> testRemoveObjectNamedWithExistingObject [

	| chest |
	chest := Chest new.
	chest
		at: 'toto' put: 'toto';
		at: 'tata' put: 'tata';
		at: 'titi' put: 'titi'.

	self assert: (chest at: 'toto') equals: 'toto'.

	chest removeObjectNamed: 'toto'.

	self should: [ chest at: 'toto' ] raise: KeyNotFound
]

{ #category : #tests }
ChestTests >> testRemoveObjectNamedWithObjectThatDoesNotExist [

	| chest |
	chest := Chest new.
	chest
		at: 'toto' put: 'toto';
		at: 'tata' put: 'tata';
		at: 'titi' put: 'titi'.

	chest removeObjectNamed: 'toto'.

	self
		should: [ chest removeObjectNamed: 'toto' ]
		raise: ObjectNotInChestError
]

{ #category : #tests }
ChestTests >> testRemoveWithDefaultInstance [

	| chest |
	chest := Chest defaultInstance.

	self assert: (Chest named: chest name) identicalTo: chest.

	chest remove.

	self assert: (Chest named: chest name) identicalTo: chest
]

{ #category : #tests }
ChestTests >> testRenameObjectInto [

	| chest object |
	chest := Chest new.
	object := Object new.
	chest at: 'toto' put: object.

	self assert: (chest at: 'toto') identicalTo: object.

	chest renameObject: object into: 'tata'.

	self assert: (chest at: 'tata') identicalTo: object.
	self should: [ chest at: 'toto' ] raise: KeyNotFound
]

{ #category : #tests }
ChestTests >> testRenameObjectIntoRaisesErrorWhenObjectIsNotInChest [

	| chest objectToBeRenamed objectInChest |
	chest := Chest new.
	objectToBeRenamed := Object new.
	objectInChest := Object new.
	chest at: 'tata' put: objectInChest.

	self
		shouldnt: [ chest renameObject: objectInChest into: 'toto' ]
		raise: [ ObjectNotInChestError ].

	self
		should: [ chest renameObject: objectToBeRenamed into: 'titi' ]
		raise: ObjectNotInChestError.

	self assert: (chest at: 'toto') identicalTo: objectInChest.
	self should: [ chest at: 'titi' ] raise: KeyNotFound
]

{ #category : #tests }
ChestTests >> testRenameObjectIntoRaisesErrorWhenObjectOfSameNameAlreadyExists [

	| chest objectToBeRenamed objectAlreadyHavingNewName |
	chest := Chest new.
	objectToBeRenamed := Object new.
	objectAlreadyHavingNewName := Object new.
	chest at: 'tata' put: objectAlreadyHavingNewName.
	chest at: 'toto' put: objectToBeRenamed.

	self
		assert: (chest at: 'tata')
		identicalTo: objectAlreadyHavingNewName.
	self assert: (chest at: 'toto') identicalTo: objectToBeRenamed.

	self
		should: [ chest renameObject: objectToBeRenamed into: 'tata' ]
		raise: ChestKeyAlreadyInUseError.

	self
		assert: (chest at: 'tata')
		identicalTo: objectAlreadyHavingNewName.
	self assert: (chest at: 'toto') identicalTo: objectToBeRenamed
]

{ #category : #tests }
ChestTests >> testRenamingChestChangesItsKeyInDictionary [

	| chest firstNameAvailable oldName |
	chest := Chest new.
	oldName := chest name.
	firstNameAvailable := self firstChestNameAvailable.

	chest name: firstNameAvailable.

	self assert: chest name equals: firstNameAvailable.
	self assert: (Chest named: firstNameAvailable) identicalTo: chest.
	self should: [ Chest named: oldName ] raise: KeyNotFound
]

{ #category : #tests }
ChestTests >> testRenamingChestRaisesErrorWhenChestOfSameNameAlreadyExists [

	| chestToBeRenamed firstNameAvailable oldName chestAlreadyHavingNewName |
	chestToBeRenamed := Chest new.
	oldName := chestToBeRenamed name.
	firstNameAvailable := self firstChestNameAvailable.
	chestAlreadyHavingNewName := Chest newNamed: firstNameAvailable.

	self
		should: [ chestToBeRenamed name: firstNameAvailable ]
		raise: ChestKeyAlreadyInUseError.

	self assert: chestToBeRenamed name equals: oldName.
	self
		assert: (Chest named: firstNameAvailable)
		identicalTo: chestAlreadyHavingNewName.
	self assert: (Chest named: oldName) identicalTo: chestToBeRenamed
]
