"
Announcer for `Chest` that announces to its subscribers when:

- a new chest has been created
- a chest has been removed
- the content of a chest has been modified
"
Class {
	#name : #ChestAnnouncer,
	#superclass : #Announcer,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #Chest
}

{ #category : #initialization }
ChestAnnouncer class >> initialize [

	uniqueInstance := self new
]

{ #category : #initialization }
ChestAnnouncer class >> uniqueInstance [

	^ uniqueInstance
]

{ #category : #'event system' }
ChestAnnouncer >> notifyChestRemoved: aChest [

	self announce: (ChestRemoved new: aChest)
]

{ #category : #'event system' }
ChestAnnouncer >> notifyContentsOfChest: aChest updatedTo: contents [

	self announce: (ChestUpdated new: aChest withContent: contents)
]

{ #category : #'event system' }
ChestAnnouncer >> notifyNewChest: aChest [

	self announce: (ChestCreated new: aChest)
]
