Class {
	#name : 'ChestEventListenerForTest',
	#superclass : 'Object',
	#instVars : [
		'chestRemovedReceived',
		'contentOfChestUpdatedReceived',
		'newChestReceived',
		'removedChest',
		'updatedChest',
		'newContentsOfUpdatedChest',
		'newChest'
	],
	#category : 'Chest-Tests',
	#package : 'Chest-Tests'
}

{ #category : 'accessing' }
ChestEventListenerForTest >> chestRemovedReceived [
	^ chestRemovedReceived
]

{ #category : 'accessing' }
ChestEventListenerForTest >> contentOfChestUpdatedReceived [
	^ contentOfChestUpdatedReceived
]

{ #category : 'initialization' }
ChestEventListenerForTest >> eventChestRemoved: aChestRemovedAnnouncement [
	chestRemovedReceived := true.
	removedChest := aChestRemovedAnnouncement removedChest 
]

{ #category : 'initialization' }
ChestEventListenerForTest >> eventContentOfChestUpdated: aChestUpdatedAnnouncement [
	contentOfChestUpdatedReceived := true.
	updatedChest := aChestUpdatedAnnouncement updatedChest .
	newContentsOfUpdatedChest := aChestUpdatedAnnouncement newContent 

]

{ #category : 'initialization' }
ChestEventListenerForTest >> eventNewChest: aChestCreatedAnnouncement [
	newChestReceived := true.
	newChest := aChestCreatedAnnouncement createdChest 
]

{ #category : 'initialization' }
ChestEventListenerForTest >> initialize [
	chestRemovedReceived := false.
	contentOfChestUpdatedReceived := false.
	newChestReceived := false
]

{ #category : 'accessing' }
ChestEventListenerForTest >> newChest [
	^ newChest
]

{ #category : 'accessing' }
ChestEventListenerForTest >> newChestReceived [
	^ newChestReceived
]

{ #category : 'accessing' }
ChestEventListenerForTest >> newContentsOfUpdatedChest [
	^ newContentsOfUpdatedChest
]

{ #category : 'accessing' }
ChestEventListenerForTest >> removedChest [
	^ removedChest
]

{ #category : 'updating' }
ChestEventListenerForTest >> subscribeToChestAnnouncer [

	Chest announcer weak when: ChestCreated send: #eventNewChest: to: self.
	Chest announcer weak when: ChestUpdated send: #eventContentOfChestUpdated: to: self.
	Chest announcer weak when: ChestRemoved send: #eventChestRemoved: to: self.
	
	
]

{ #category : 'accessing' }
ChestEventListenerForTest >> updatedChest [
	^ updatedChest
]
