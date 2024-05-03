"
Request dialog used by `ChestPresenter` to ask users to name/rename a chest or an object in a chest.
"
Class {
	#name : 'ChestRequestDialogPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'titleLabel',
		'image',
		'text',
		'actionBar',
		'acceptBlock',
		'cancelBlock'
	],
	#category : 'Chest-Presenters',
	#package : 'Chest',
	#tag : 'Presenters'
}

{ #category : 'instance creation' }
ChestRequestDialogPresenter class >> confirm: requestText onAccept: acceptBlock onCancel: cancelBlock [

	^ self basicNew
		  titleLabel: requestText;
		  acceptBlock: acceptBlock;
		  cancelBlock: cancelBlock;
		  initialize;
		  disableText;
		  yourself
]

{ #category : 'instance creation' }
ChestRequestDialogPresenter class >> request: requestText onAccept: aBlock [

	^ self basicNew
		  titleLabel: requestText;
		  acceptBlock: aBlock;
		  initialize
]

{ #category : 'accessing' }
ChestRequestDialogPresenter >> acceptBlock [

	^ acceptBlock ifNil: [ acceptBlock := [ :textContent |  ] ]
]

{ #category : 'accessing' }
ChestRequestDialogPresenter >> acceptBlock: anObject [

	acceptBlock := anObject
]

{ #category : 'layout' }
ChestRequestDialogPresenter >> buildActionBar [

	^ self newActionBar
		  add: (self newButton
				   label: 'Ok';
				   icon: (self iconNamed: #smallOk);
				   help: 'Add.';
				   action: [ 
					   self acceptBlock cull: text text.
					   owner dismiss ];
				   yourself);
		  add: (self newButton
				   label: 'Cancel';
				   icon: (self iconNamed: #smallCancel);
				   help: 'Remove.';
				   action: [ 
					   self cancelBlock cull: text text.
					   owner dismiss ];
				   yourself);
		  yourself
]

{ #category : 'accessing' }
ChestRequestDialogPresenter >> cancelBlock [

	^ cancelBlock ifNil: [ cancelBlock := [ :aText| ] ]
]

{ #category : 'accessing' }
ChestRequestDialogPresenter >> cancelBlock: anObject [

	cancelBlock := anObject
]

{ #category : 'layout' }
ChestRequestDialogPresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  borderWidth: 5;
		  spacing: 5;
		  add: (SpBoxLayout newLeftToRight
				   vAlignCenter;
				   spacing: 5;
				   add: #image expand: false;
				   add: #titleLabel;
				   yourself)
		  expand: false;
		  add: #text;
		  add: #actionBar;
		  yourself
]

{ #category : 'configuration' }
ChestRequestDialogPresenter >> disableText [

	text beNotEditable
]

{ #category : 'layout' }
ChestRequestDialogPresenter >> initializePresenters [

	actionBar := self buildActionBar.

	text := self newText.
	image := self newImage image: (self application iconNamed: #question)
]

{ #category : 'accessing' }
ChestRequestDialogPresenter >> text [

	^ text
]

{ #category : 'accessing' }
ChestRequestDialogPresenter >> titleLabel: aString [

	titleLabel := self newLabel.
	titleLabel label: aString
]
