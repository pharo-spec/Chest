Class {
	#name : #ChestCopyObjectCommand,
	#superclass : #SpCodeSelectionCommand,
	#category : #'Chest-Commands'
}

{ #category : #default }
ChestCopyObjectCommand class >> defaultDescription [

	^ 'Store the result of the selected expression in a clipboard chest to paste it later'
]

{ #category : #defaults }
ChestCopyObjectCommand class >> defaultIconName [

	^ #smallCopy
]

{ #category : #default }
ChestCopyObjectCommand class >> defaultName [

	^ 'Copy object in a clipboard chest'
]

{ #category : #executing }
ChestCopyObjectCommand >> execute [

	self evaluateSelectionAndDo: [ :result |
		[ ClipboardChest at: ClipboardChest clipboardEntryName put: result ]
			on: ChestKeyAlreadyInUseError
			do: [
				ClipboardChest removeObjectNamed:
					ClipboardChest clipboardEntryName.
				ClipboardChest at: ClipboardChest clipboardEntryName put: result ] ]
]
