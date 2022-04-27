Class {
	#name : #DefaultChest,
	#superclass : #Chest,
	#category : #Chest
}

{ #category : #'instance creation' }
DefaultChest class >> new [
	
	^ self newNamed: 'Default'
]

{ #category : #removing }
DefaultChest >> remove [
	"The default chest cannot be removed"

	^ self
]
