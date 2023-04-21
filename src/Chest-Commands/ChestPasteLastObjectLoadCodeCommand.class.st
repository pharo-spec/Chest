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

	^ 'Paste last object copied to clipboard'
]

{ #category : #default }
ChestPasteLastObjectLoadCodeCommand class >> defaultShortcutKey [

	^ $v meta shift
]

{ #category : #'instance creation' }
ChestPasteLastObjectLoadCodeCommand class >> forSpecContext: aContext [

	^ self
		  forSpecContext: aContext
		  withChestName: ClipboardChest defaultInstance name
		  withObjectName: ClipboardChest clipboardEntryName
]

{ #category : #accessing }
ChestPasteLastObjectLoadCodeCommand >> description [

	^ self class defaultDescription
]

{ #category : #accessing }
ChestPasteLastObjectLoadCodeCommand >> name [ 

	^ self class defaultName
]
