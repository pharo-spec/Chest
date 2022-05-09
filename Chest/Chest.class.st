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
		'lastUsedNumber'
	],
	#classVars : [
		'ChestDictionary',
		'DefaultInstance',
		'NextAvailableID',
		'Subscribers'
	],
	#category : #Chest
}

{ #category : #api }
Chest class >> add: anObject [
	^ self defaultInstance add: anObject
]

{ #category : #accessing }
Chest class >> allChests [
	^ ChestDictionary values
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

	(ChestDictionary includesKey: aKey) ifTrue: [ 
		ChestKeyAlreadyInUseError signal:
			'You cannot create a chest named ' , aKey
			, ' as it already exists' ].
		ChestDictionary at: aKey put: aChest.
]

{ #category : #accessing }
Chest class >> chestDictionary [
	^ ChestDictionary copy
]

{ #category : #api }
Chest class >> contents [
	^ self defaultInstance contents
]

{ #category : #accessing }
Chest class >> defaultInstance [
	^ DefaultInstance
	
]

{ #category : #private }
Chest class >> getNewID [
	| newId |
	newId := NextAvailableID.
	NextAvailableID := NextAvailableID + 1.
	^ newId
]

{ #category : #'class initialization' }
Chest class >> initialize [
	Subscribers := OrderedCollection new.
	ChestDictionary := Dictionary new.
	NextAvailableID := 1.
	DefaultInstance := DefaultChest new.
]

{ #category : #'class initialization' }
Chest class >> named: aString [

	"Returns the Chest whose name is aString"

	^ ChestDictionary at: aString
]

{ #category : #api }
Chest class >> new [
	
	^ self newNamed: 'Unnamed' , self getNewID asString.
]

{ #category : #api }
Chest class >> newNamed: aString [

	| chest |
	chest := super new.
	chest name: aString.
	self notifyNewChest: chest.
	^ chest
]

{ #category : #'event system' }
Chest class >> notifyChestRemoved: aChest [
	Subscribers do: [ :subscriber | subscriber eventChestRemoved: aChest]
]

{ #category : #'event system' }
Chest class >> notifyContentsOfChest: aChest updatedTo: contents [
	Subscribers do: [ :subscriber | subscriber eventContentOfChest: aChest updatedTo: contents]
]

{ #category : #'event system' }
Chest class >> notifyNewChest: aChest [
	Subscribers do: [ :subscriber | subscriber eventNewChest: aChest ].
]

{ #category : #api }
Chest class >> remove: anObject [
	^ self defaultInstance remove: anObject
]

{ #category : #removing }
Chest class >> removeChest: aChest [
	
	^ self removeChestNamed: aChest name.
	
]

{ #category : #removing }
Chest class >> removeChestNamed: aKey [
	| removedChest |
	removedChest := ChestDictionary removeKey: aKey.
	self notifyChestRemoved: removedChest.
]

{ #category : #api }
Chest class >> removeObjectNamed: aString [
	^ self defaultInstance removeObjectNamed: aString
]

{ #category : #'event system' }
Chest class >> subscribeToUpdates: subscriber [
	"subscriber will be sent the #event_newChest: and #event_contentOfChest:updatedTo: and #event_chestRemoved: messages when these events happen"
	Subscribers add: subscriber
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

	(self contentsPrivate includesKey: aString) ifTrue: [ ChestKeyAlreadyInUseError signal: 'You cannot put an object named ' , aString , ' as it already exist in this chest' ].
	(self contentsPrivate keyForIdentity: anObject) ifNotNil: [ :key | self contentsPrivate removeKey: key ]. "The idea is that an object has a unique key in a chest: its name. So if the object was already in a chest, the former key should be removed."
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

	| oldName |
	oldName := self name.
	self class at: aString putChestIfKeyIsAbsent: self .
	name := aString.
	oldName ifNotNil: [ self class removeChestNamed: oldName ]
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
