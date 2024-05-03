"
Announcement made by a `ChestAnnouncer` when the content of a chest has been updated.
"
Class {
	#name : 'ChestUpdated',
	#superclass : 'Announcement',
	#instVars : [
		'updatedChest',
		'newContent'
	],
	#category : 'Chest-Model',
	#package : 'Chest',
	#tag : 'Model'
}

{ #category : 'instance creation' }
ChestUpdated class >> new: updatedChest withContent: newContent [

	^ self new
		  updatedChest: updatedChest;
		  newContent: newContent;
		  yourself
]

{ #category : 'accessing' }
ChestUpdated >> newContent [

	^ newContent
]

{ #category : 'accessing' }
ChestUpdated >> newContent: anObject [

	newContent := anObject
]

{ #category : 'accessing' }
ChestUpdated >> updatedChest [

	^ updatedChest
]

{ #category : 'accessing' }
ChestUpdated >> updatedChest: anObject [

	updatedChest := anObject
]
