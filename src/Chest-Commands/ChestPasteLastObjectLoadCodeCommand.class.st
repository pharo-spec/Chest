Class {
	#name : #ChestPasteLastObjectLoadCodeCommand,
	#superclass : #ChestPasteLoadCodeCommand,
	#category : #'Chest-Commands'
}

{ #category : #default }
ChestPasteLastObjectLoadCodeCommand class >> defaultDescription [

	^ 'Paste last object from clipboard chest'
]

{ #category : #default }
ChestPasteLastObjectLoadCodeCommand class >> defaultName [

	^ 'ChestObjectPasteLast'
]

{ #category : #default }
ChestPasteLastObjectLoadCodeCommand class >> defaultShortcutKey [

	^ $v meta shift
]

{ #category : #'instance creation' }
ChestPasteLastObjectLoadCodeCommand class >> forSpecContext: aContext [

	^ self
		  forSpecContext: aContext
		  withChestName: ClipboardChest defaultInstanceName
		  withObjectName: ClipboardChest clipboardEntryName
]
