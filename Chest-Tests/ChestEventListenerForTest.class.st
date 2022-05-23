Class {
	#name : #ChestEventListenerForTest,
	#superclass : #Object,
	#instVars : [
		'chestRemovedReceived',
		'contentOfChestUpdatedReceived',
		'newChestReceived',
		'removedChest',
		'updatedChest',
		'newContentsOfUpdatedChest',
		'newChest'
	],
	#category : #'Chest-Tests'
}

{ #category : #accessing }
ChestEventListenerForTest >> chestRemovedReceived [
	^ chestRemovedReceived
]

{ #category : #accessing }
ChestEventListenerForTest >> contentOfChestUpdatedReceived [
	^ contentOfChestUpdatedReceived
]

{ #category : #initialization }
ChestEventListenerForTest >> eventChestRemoved: aChestRemovedAnnouncement [
	chestRemovedReceived := true.
	removedChest := aChestRemovedAnnouncement removedChest 
]

{ #category : #initialization }
ChestEventListenerForTest >> eventContentOfChest: aChest updatedTo: contents [
	contentOfChestUpdatedReceived := true.
	updatedChest := aChest.
	newContentsOfUpdatedChest := contents

]

{ #category : #initialization }
ChestEventListenerForTest >> eventContentOfChestUpdated: aChestUpdatedAnnouncement [
	contentOfChestUpdatedReceived := true.
	updatedChest := aChestUpdatedAnnouncement updatedChest .
	newContentsOfUpdatedChest := aChestUpdatedAnnouncement newContent 

]

{ #category : #initialization }
ChestEventListenerForTest >> eventNewChest: aChestCreatedAnnouncement [
	newChestReceived := true.
	newChest := aChestCreatedAnnouncement createdChest 
]

{ #category : #initialization }
ChestEventListenerForTest >> initialize [
	chestRemovedReceived := false.
	contentOfChestUpdatedReceived := false.
	newChestReceived := false
]

{ #category : #accessing }
ChestEventListenerForTest >> newChest [
	^ newChest
]

{ #category : #accessing }
ChestEventListenerForTest >> newChestReceived [
	^ newChestReceived
]

{ #category : #accessing }
ChestEventListenerForTest >> newContentsOfUpdatedChest [
	^ newContentsOfUpdatedChest
]

{ #category : #accessing }
ChestEventListenerForTest >> removedChest [
	^ removedChest
]

{ #category : #accessing }
ChestEventListenerForTest >> updatedChest [
	^ updatedChest
]
