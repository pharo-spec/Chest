"
Command that allows to paste (inject) code to load an object from a chest into a spec context
"
Class {
	#name : 'ChestPasteLoadCodeCommand',
	#superclass : 'ChestCommand',
	#instVars : [
		'chestName',
		'objectName'
	],
	#category : 'Chest-Commands',
	#package : 'Chest-Commands'
}

{ #category : 'default' }
ChestPasteLoadCodeCommand class >> defaultDescription [

	^ 'Paste object from a chest'
]

{ #category : 'default' }
ChestPasteLoadCodeCommand class >> defaultIconName [

	^ #smallPaste
]

{ #category : 'default' }
ChestPasteLoadCodeCommand class >> defaultName [

	^ 'ChestObjectPaste'
]

{ #category : 'default' }
ChestPasteLoadCodeCommand class >> defaultShortcutKey [

	^ $v meta , $l meta
]

{ #category : 'instance creation' }
ChestPasteLoadCodeCommand class >> forSpecContext: specContext withChestName: chestName withObjectName: objectName [

	^ self new
		  chestName: chestName;
		  objectName: objectName;
		  context: specContext;
		  name: chestName;
		  asSpecCommand
]

{ #category : 'executing' }
ChestPasteLoadCodeCommand >> buildInjectedCode [

	^ '(Chest named: ''{1}'') at: ''{2}''' format: {
			  chestName.
			  objectName }
]

{ #category : 'accessing' }
ChestPasteLoadCodeCommand >> chestName [

	^ chestName
]

{ #category : 'accessing' }
ChestPasteLoadCodeCommand >> chestName: anObject [

	chestName := anObject
]

{ #category : 'accessing' }
ChestPasteLoadCodeCommand >> description [

	^ 'Paste object from chest > {1} > {2}' format: {
			  chestName.
			  objectName }
]

{ #category : 'executing' }
ChestPasteLoadCodeCommand >> execute [

	| code |
	code := self buildInjectedCode.
	Clipboard clipboardText: code.
	context doTextPaste
]

{ #category : 'accessing' }
ChestPasteLoadCodeCommand >> name [

	^ objectName
]

{ #category : 'accessing' }
ChestPasteLoadCodeCommand >> objectName [

	^ objectName
]

{ #category : 'accessing' }
ChestPasteLoadCodeCommand >> objectName: anObject [

	objectName := anObject
]
