Class {
	#name : #ChestCreated,
	#superclass : #Announcement,
	#instVars : [
		'createdChest'
	],
	#category : #Chest
}

{ #category : #'instance creation' }
ChestCreated class >> new: newChest [

	^ self new
		createdChest: newChest;
		yourself
]

{ #category : #accessing }
ChestCreated >> createdChest [

	^ createdChest
]

{ #category : #accessing }
ChestCreated >> createdChest: newChest [

	createdChest := newChest
]
