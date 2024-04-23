Class {
	#name : 'ClipboardChest',
	#superclass : 'WeakChest',
	#category : 'Chest',
	#package : 'Chest'
}

{ #category : 'icons' }
ClipboardChest class >> chestIcon [

	^ Smalltalk ui icons iconNamed: 'smallCopy'
]

{ #category : 'accessing' }
ClipboardChest class >> clipboardEntryName [

	^ 'clipboardEntry'
]

{ #category : 'default values' }
ClipboardChest class >> defaultInstanceName [ 

	^ 'ClipboardDefault'
]

{ #category : 'accessing' }
ClipboardChest >> clipboardEntryName [

	^ self class clipboardEntryName 
]
