"
Chest is an object manager that allows to store objects in chests. The objects that are stored in a chest have a name, which is a unique key in their chest. A chest itself also has a name, which is a unique key in the `ChestDictionary` in `Chest class`.

Chest is very defensive: it won't allow you to create or to rename a chest or an object in a chest if it would cause the deletion of another chest or another object in a chest.
Chest has a default instance that is the only chest that can't be deleted. Most of `Chest API` can be used on `Chest class`, which actually calls the corresponding method on its default instance.

In `SpCodePresenter` instances with `SpCodeScriptingInteractionModel`, you can select objects to store them in the chest of your choice; or load any object from any chest into this presenter.

# Public API and Key Messages

## `Chest` API

- `Chest>>#add:` : adds the object in argument to the chest with a default name that is in the form of 'chestName_autoIncrementedNumber'
- `Chest>>#at: ` : gives the object in the chest whose name is the string in argument if it exists, else `KeyNotFound`
- `Chest>>#at:put:` : adds the object in second argument to the chest with the name in first argument if no other object is already named so, else `ChestKeyAlreadyInUseError`
- `Chest>>#contents` : gives a copy of a chest's contents as a dictionary
- `Chest>>#remove:` : removes the object in argument from a chest if it is there, else `KeyNotFound`
- `Chest>>#removeObjectNamed:` : removes the object whose name is in argument if it is there, else `ObjectNotInChestError`
The 6 messages above can be sent to `Chest class` unlike the ones below:
- `Chest>>#empty`: empties a chest.
- `Chest>>#remove` : completely deletes this chest
- `Chest>>#name` : gives this chest's name
- `Chest>>#name:` : renames this chest as the string in argument if no other chest is already named so, else `ChestKeyAlreadyInUseError`
- `Chest>>#renameObject:into:` : renames the object (first argument) in a chest as the string in second argument; if the object is in the chest else `ObjectNotInChestError` and if no other object is already named so else `ChestKeyAlreadyInUseError`
- `Chest>>#inspectAt` : inspect in a chest the object whose name is in argument

## `Chest class` API

- `Chest class>>#allChests` : gives an ordered collection that contains all chests
- `Chest class>>#chestDictionary` : gives all chests with their names as a dictionary
- `Chest class>>#named:` : gives the chest that is named as the string in argument
- `Chest class>>#defaultInstance` ( or `Chest class>>#default`) : gives the default chest that is used when you use `Chest` API on `Chest class`
- `Chest class>>#inChest:at:put:` : puts an object with a given name in a chest of a given name that is created it it doesn;t exist yet.
- `Chest class>>#announcer` : helper that gives the unique instance of `ChestAnnouncer`
- `Chest class>>#unsubscribe:` : helper that unsubscribes its argument from the unique instance of `ChestAnnouncer`

### How to create instances 
- `Chest class>>#new` : creates a chest with a default name that is in the form of 'Chest_autoIncrementedNumber'
- `Chest class>>#newNamed:` : creates a chest with the name given in parameter if no other chest is already named so, else `ChestKeyAlreadyInUseError`

#### Example

```language=Pharo
	Chest new. ""its name is 'Chest_1' if no other chest have been created before""
	Chest new. ""its name is 'Chest_2' if no other chest have been created before""
	Chest newNamed: 'toto'. ""its name is 'toto'""
	Chest newNamed: 'toto'. ""ChestKeyAlreadyInUseError as a chest named 'toto' already exists""
	
	(Chest named: 'toto') add: 42.
	""42 has the key 'toto_1' in the chest named 'toto'""
	
	(Chest named: 'toto') at: 'toto' put: 42.
	(Chest named: 'toto') at: 'toto'. ""returns 42""
	""42 has the key 'toto' and not 'toto_1' anymore as an object has a unique key in a chest.""
	
	(Chest named: 'toto') at: 'toto' put: 72.
	""72 is not put in the chest: a ChestKeyAlreadyInUseError is raised as 42 already has the key 'toto'""
	
	(Chest named: 'toto') renameObject: 42 into: 'tata' .
	""42 has now the key 'tata' in the chest named 'toto'""
	
	(Chest named: 'toto') removeObjectNamed: 'tata'.
	""42 is removed as it had the key 'tata'""
	
	(Chest named: 'toto') at: 'toto' put: 72.
	(Chest named: 'toto') remove: 72. 
	""72 is not in the chest anymore""
	
	(Chest named: 'toto') remove: 72. ""KeyNotFound""
	(Chest named: 'toto') renameObject: 72 into: 'toto'. ""ObjectNotInChestError""
	(Chest named: 'toto') removeObjectNamed: 'toto'. ""ObjectNotInChestError""
	
	(Chest named: 'toto') 	at: 'toto' put: 42;
									at: 'tata' put: 72;
									renameObject: 42 into: 'tata'. ""ChestKeyAlreadyInUseError""
	
	(Chest named: 'toto') contents at: 'tata' ""returns 72""
							
	Chest defaultInstance	name: 'toto' ""ChestKeyAlreadyInUseError""					
	
	(Chest named: 'toto') remove.
	""deletes the chest named 'toto', and all objects inside""
	
	Chest named: 'toto'. ""KeyNotFound""
	Chest defaultInstance name: 'toto'. ""the default chest is now named 'toto'""
	
	Chest defaultInstance remvove. ""the default chest is still there as it can't be removed""
	
	Chest add: 42. ""adds 42 to the default chest""
	
	Chest inChest: 'titi' at: 'tata' put: 42 ""creates the chest named 'titi' as it doesn't exist, and put 42 in it with the name 'tata' ""
	
	Chest inChest: 'titi' at: 'toto' put: 43 ""puts 43 in the chest named 'titi' with the name 'toto'""
```
 
# Internal Representation and Key Implementation Points.

    Instance Variables
	contents:		<Dictionary<Object>>
	lastUsedNumber:	 used to generate default names that aren't already used	<Integer>
	name:		<String>
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
		'NextAvailableID'
	],
	#classInstVars : [
		'announcer'
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

{ #category : #accessing }
Chest class >> announcer [

	^ announcer ifNil: [ announcer := ChestAnnouncer uniqueInstance ]
]

{ #category : #api }
Chest class >> at: anIndex [

	^ self defaultInstance at: anIndex
]

{ #category : #api }
Chest class >> at: aKey put: anObject [

	^ self defaultInstance at: aKey put: anObject
]

{ #category : #api }
Chest class >> at: aKey put: anObject ifPresent: aBlock [

	^ self defaultInstance at: aKey put: anObject ifPresent: aBlock
]

{ #category : #accessing }
Chest class >> at: aKey putChestIfKeyIsAbsent: aChest [

	(ChestDictionary includesKey: aKey) ifTrue: [ 
		ChestKeyAlreadyInUseError signal:
			'You cannot create a chest named ' , aKey , ' as it already exists' ].
	ChestDictionary at: aKey put: aChest
]

{ #category : #accessing }
Chest class >> chestDictionary [

	^ ChestDictionary copy
]

{ #category : #icons }
Chest class >> chestIcon [

	^ Smalltalk ui icons iconNamed: 'group'
]

{ #category : #api }
Chest class >> contents [

	^ self defaultInstance contents
]

{ #category : #accessing }
Chest class >> default [

	^ self defaultInstance 
]

{ #category : #accessing }
Chest class >> defaultInstance [

	^ DefaultInstance ifNil: [ DefaultInstance := self newNamed: 'Default' ]
]

{ #category : #private }
Chest class >> getNewID [

	| newId |
	newId := NextAvailableID.
	NextAvailableID := NextAvailableID + 1.
	^ newId
]

{ #category : #api }
Chest class >> inChest: aChestName at: aKey put: anObject [

	| chest |
	[ chest := self named: aChestName ]
		on: KeyNotFound
		do: [ chest newNamed: aChestName ].

	^ chest at: aKey put: anObject
]

{ #category : #'class initialization' }
Chest class >> initialize [

	ChestDictionary := Dictionary new.
	NextAvailableID := 1.
	DefaultInstance := nil
]

{ #category : #'class initialization' }
Chest class >> named: aString [

	"Returns the Chest whose name is aString"

	^ ChestDictionary at: aString
]

{ #category : #api }
Chest class >> new [

	^ self newNamed: 'Chest_' , self getNewID asString
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

	self announcer notifyChestRemoved: aChest
]

{ #category : #'event system' }
Chest class >> notifyContentsOfChest: aChest updatedTo: contents [

	self announcer notifyContentsOfChest: aChest updatedTo: contents
]

{ #category : #'event system' }
Chest class >> notifyNewChest: aChest [

	self announcer notifyNewChest: aChest
]

{ #category : #api }
Chest class >> remove: anObject [

	^ self defaultInstance remove: anObject
]

{ #category : #removing }
Chest class >> removeChest: aChest [

	^ self removeChestNamed: aChest name
]

{ #category : #removing }
Chest class >> removeChestNamed: aKey [

	| removedChest |
	removedChest := ChestDictionary removeKey: aKey.
	removedChest == DefaultInstance ifTrue: [ DefaultInstance := nil ].
	self notifyChestRemoved: removedChest
]

{ #category : #api }
Chest class >> removeObjectNamed: aString [

	^ self defaultInstance removeObjectNamed: aString
]

{ #category : #subscription }
Chest class >> unsubscribe: subscriber [

	self announcer unsubscribe: subscriber
]

{ #category : #api }
Chest >> add: anObject [

	"Adds an object to the chest. Returns the index at which it has been added."

	| nameForTheObject |
	nameForTheObject := self nextDefaultNameForObject.
	lastUsedNumber := lastUsedNumber + 1.
	^ self at: nameForTheObject put: anObject
]

{ #category : #api }
Chest >> at: aString [

	^ self contentsPrivate at: aString
]

{ #category : #api }
Chest >> at: aString put: anObject [

	(self contentsPrivate includesKey: aString) ifTrue: [ 
		ChestKeyAlreadyInUseError signal:
			'You cannot put an object named ' , aString
			, ' as it already exist in this chest' ].
	(self contentsPrivate keyForIdentity: anObject) ifNotNil: [ :key | 
		self contentsPrivate removeKey: key ]. "The idea is that an object has a unique key in a chest: its name. So if the object was already in a chest, the former key should be removed."
	self contentsPrivate at: aString put: anObject.
	self contentsUpdated.
	^ aString
]

{ #category : #accessing }
Chest >> at: aString put: anObject ifPresent: aBlock [

	[ self at: aString put: anObject ]
		on: ChestKeyAlreadyInUseError
		do: aBlock
]

{ #category : #validating }
Chest >> checkValidName: aString [

	[ Slot checkValidName: aString ] on: InvalidSlotName do: [ ChestInvalidNameError signal ]
]

{ #category : #'private - tree building' }
Chest >> chestChildren [

	^ self contentsPrivate associations
]

{ #category : #evaluation }
Chest >> chestEvaluation [

	^ self contentsPrivate asString
]

{ #category : #'private - tree building' }
Chest >> chestName [

	^ self name
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

{ #category : #testing }
Chest >> isChest [

	^ true
]

{ #category : #api }
Chest >> name [

	^ name
]

{ #category : #api }
Chest >> name: aString [

	| oldName |
	oldName := self name.
	self checkValidName: aString.
	self class at: aString putChestIfKeyIsAbsent: self.
	name := aString.
	oldName ifNotNil: [ self class removeChestNamed: oldName ]
]

{ #category : #accessing }
Chest >> nextDefaultNameForObject [

	^ self name , '_' , lastUsedNumber asString
]

{ #category : #removing }
Chest >> remove [

	"Remove this chest from the list of all chests"

	self class removeChest: self
]

{ #category : #accessing }
Chest >> remove: anObject [

	(contents keyForIdentity: anObject) ifNotNil: [ :key | 
		contents removeKey: key ].
	self contentsUpdated
]

{ #category : #accessing }
Chest >> removeObjectNamed: aString [

	[ self contentsPrivate removeKey: aString ]
		on: KeyNotFound
		do: [ ObjectNotInChestError signal ].
	self contentsUpdated
]

{ #category : #accessing }
Chest >> renameObject: anObject into: aString [

	| oldKey |
	(oldKey := self contentsPrivate keyForIdentity: anObject) ifNil: [ 
		ObjectNotInChestError signal ].
	self at: aString put: anObject.
	self contentsUpdated
]
