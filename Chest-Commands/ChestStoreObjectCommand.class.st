Class {
	#name : #ChestStoreObjectCommand,
	#superclass : #SpCodeSelectionCommand,
	#category : #'Chest-Commands'
}

{ #category : #'accessing - defaults' }
ChestStoreObjectCommand class >> defaultDescription [

	^ 'Store the result of the selected expression in the chest of your choice'
]

{ #category : #'accessing - defaults' }
ChestStoreObjectCommand class >> defaultIconName [

	^ #group
]

{ #category : #'accessing - defaults' }
ChestStoreObjectCommand class >> defaultName [

	^ 'Store object in a chest'
]

{ #category : #'accessing - defaults' }
ChestStoreObjectCommand class >> defaultShortcutKey [

	^ $c meta, $s meta
]

{ #category : #execution }
ChestStoreObjectCommand >> execute [

	self evaluateSelectionAndDo: [ :result | self storeObject: result ]
]

{ #category : #execution }
ChestStoreObjectCommand >> storeObject: result [
	| chest |
	chest := UIManager default chooseFrom: (Chest allChests collect: [ :each | each name ]) values: Chest allChests.
	^ self storeObject: result intoChest: chest.
]

{ #category : #execution }
ChestStoreObjectCommand >> storeObject: result intoChest: chest [

	chest ifNotNil: [ chest add: result ]
]
