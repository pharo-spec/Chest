"
Represent a collection of ChestObject

# Instance Variables
	- contents: OrderedCollection<ChestObject>
		The objects contained in this Chest instance
	- name: String
		Name of this Chest instance
	- id: Integer
		Unique id of this Chest instance
		
# Class Variables
	- defaultInstance: Chest
		The default Chest instance
	- nextAvailableID: Integer
		The next id that is not used by any Chest. To be given to the next Chest that is created.
	- IDToChestInstance: Dictionary<Integer, Chest>
		Maps chest ids to chest instances
"
Class {
	#name : #Chest,
	#superclass : #Object,
	#instVars : [
		'contents',
		'name',
		'id',
		'lastUsedNumber'
	],
	#classVars : [
		'IDToChestInstance',
		'defaultInstance',
		'nextAvailableID',
		'subscribers'
	],
	#category : #Chest
}

{ #category : #accessing }
Chest class >> IDToChestInstance [
	^ IDToChestInstance
]

{ #category : #private }
Chest class >> IDToChestInstance: aValue [
	IDToChestInstance := aValue
]

{ #category : #api }
Chest class >> add: anObject [
	^ self defaultInstance add: anObject
]

{ #category : #accessing }
Chest class >> allChests [
	^ self IDToChestInstance values
]

{ #category : #api }
Chest class >> at: anIndex [
	^ self defaultInstance at: anIndex
]

{ #category : #api }
Chest class >> at: aKey put: anObject [
	^ self defaultInstance at: aKey put: anObject
]

{ #category : #accessing }
Chest class >> at: aKey putChestIfKeyIsAbsent: aChest [

	(self IDToChestInstance includesKey: aKey) ifTrue: [ 
		DuplicatedVariableError signal:
			'You cannot create a chest named ' , aKey
			, ' as it already exists' ].
		aChest name: aKey.
		self IDToChestInstance at: aKey put: aChest.
]

{ #category : #api }
Chest class >> contents [
	^ self defaultInstance contents
]

{ #category : #accessing }
Chest class >> defaultInstance [
	^ defaultInstance
	
]

{ #category : #private }
Chest class >> getNewID [
	| newId |
	newId := nextAvailableID.
	nextAvailableID := nextAvailableID + 1.
	^ newId
]

{ #category : #'class initialization' }
Chest class >> initialize [
	subscribers := OrderedCollection new.
	IDToChestInstance := Dictionary new.
	nextAvailableID := 1.
	defaultInstance := DefaultChest new.
]

{ #category : #'class initialization' }
Chest class >> named: aString [

	"Returns the Chest whose name is aString"

	^ self IDToChestInstance at: aString
]

{ #category : #api }
Chest class >> new [
	
	^ self newNamed: 'Unnamed' , self getNewID asString.
]

{ #category : #api }
Chest class >> newNamed: aString [

	| chest |
	chest := super new.
	self at: aString putChestIfKeyIsAbsent: chest.
	self notifyNewChest: chest.
	^ chest
]

{ #category : #'event system' }
Chest class >> notifyChestRemoved: aChest [
	subscribers do: [ :subscriber | subscriber event_chestRemoved: aChest]
]

{ #category : #'event system' }
Chest class >> notifyContentsOfChest: aChest updatedTo: contents [
	subscribers do: [ :subscriber | subscriber event_contentOfChest: aChest updatedTo: contents]
]

{ #category : #'event system' }
Chest class >> notifyNewChest: aChest [
	subscribers do: [ :subscriber | subscriber event_newChest: aChest ].
]

{ #category : #api }
Chest class >> remove: anObject [
	^ self defaultInstance remove: anObject
]

{ #category : #removing }
Chest class >> removeChest: aChest [
	self IDToChestInstance removeKey: aChest name.
	self notifyChestRemoved: aChest.
]

{ #category : #api }
Chest class >> removeObjectNamed: aString [
	^ self defaultInstance removeObjectNamed: aString
]

{ #category : #'event system' }
Chest class >> subscribeToUpdates: subscriber [
	"subscriber will be sent the #event_newChest: and #event_contentOfChest:updatedTo: and #event_chestRemoved: messages when these events happen"
	subscribers add: subscriber
]

{ #category : #api }
Chest >> add: anObject [
	"Adds an object to the chest. Returns the index at which it has been added."

	| nameForTheObject |
	nameForTheObject := 'Unnamed', lastUsedNumber asString.
	lastUsedNumber := lastUsedNumber + 1.
	^ self at: nameForTheObject put: anObject
]

{ #category : #api }
Chest >> at: aString [
	^ self contentsPrivate at: aString
]

{ #category : #api }
Chest >> at: aString put: anObject [

	(self contentsPrivate includesKey: aString) ifTrue: [ DuplicatedVariableError signal: 'You cannot put an object named ' , aString , ' as it already exist in this chest' ].
	self contentsPrivate at: aString put: anObject.
	self contentsUpdated.
	^ aString
]

{ #category : #accessing }
Chest >> contents [
	^ self contentsPrivate copy
]

{ #category : #accessing }
Chest >> contentsPrivate [
	^ contents
]

{ #category : #accessing }
Chest >> contentsUpdated [
	self class notifyContentsOfChest: self updatedTo: self contents
]

{ #category : #api }
Chest >> empty [
	self initializeContents.
	self contentsUpdated
]

{ #category : #initialization }
Chest >> initialize [
	lastUsedNumber := 1.
	self initializeContents
]

{ #category : #initialization }
Chest >> initializeContents [
	contents := Dictionary new
]

{ #category : #accessing }
Chest >> inspectAt: aString [
	^ (self contentsPrivate at: aString) inspect
]

{ #category : #api }
Chest >> name [

	^ name
]

{ #category : #api }
Chest >> name: aString [

	name := aString
]

{ #category : #removing }
Chest >> remove [
	"Remove this chest from the list of all chests"

	self class removeChest: self
]

{ #category : #accessing }
Chest >> remove: anObject [
	(contents keyForIdentity: anObject) ifNotNil: [ :key | contents removeKey: key].
	self contentsUpdated
]

{ #category : #accessing }
Chest >> removeObjectNamed:  aString [
	self contentsPrivate removeKey: aString.
	self contentsUpdated
]
