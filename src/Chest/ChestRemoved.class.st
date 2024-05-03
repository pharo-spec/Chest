"
Announcement made by a `ChestAnnouncer` when a chest has been removed.
"
Class {
	#name : 'ChestRemoved',
	#superclass : 'Announcement',
	#instVars : [
		'removedChest'
	],

	#category : 'Chest-Model',
	#package : 'Chest',
	#tag : 'Model'
}

{ #category : 'instance creation' }
ChestRemoved class >> new: removedChest [

	^ self new
		  removedChest: removedChest;
		  yourself
]

{ #category : 'accessing' }
ChestRemoved >> removedChest [

	^ removedChest
]

{ #category : 'accessing' }
ChestRemoved >> removedChest: anObject [

	removedChest := anObject
]
