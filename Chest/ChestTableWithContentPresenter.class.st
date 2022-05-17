Class {
	#name : #ChestTableWithContentPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'chestsTable',
		'chestContentsTable',
		'inputField',
		'confirmActionBar',
		'chestTableContainer',
		'chestContentTableContainer'
	],
	#category : #Chest
}

{ #category : #accessing }
ChestTableWithContentPresenter >> cancelButton [

	^ self confirmActionBar presenters last
]

{ #category : #updating }
ChestTableWithContentPresenter >> chestContentTable [

	^ chestContentsTable
]

{ #category : #'as yet unclassified' }
ChestTableWithContentPresenter >> chestContentTableContainer [

	^ chestContentTableContainer 
]

{ #category : #'as yet unclassified' }
ChestTableWithContentPresenter >> chestTableContainer [

	^ chestTableContainer 
]

{ #category : #updating }
ChestTableWithContentPresenter >> chestsTable [

	^ chestsTable
]

{ #category : #'as yet unclassified' }
ChestTableWithContentPresenter >> commandLayout [

	self chestTableContainer removeAll; add: inputField; add: #chestsTable.
	self chestContentTableContainer removeAll; add: #chestContentsTable.
	
	^ SpBoxLayout newVertical add: self defaultLayout; add: #confirmActionBar; yourself
]

{ #category : #'ui requests' }
ChestTableWithContentPresenter >> confirm: aWarning [

	^ SpConfirmDialog new
		  title: 'Warning !';
		  label: aWarning;
		  acceptLabel: 'Yes';
		  cancelLabel: 'No'
]

{ #category : #accessing }
ChestTableWithContentPresenter >> confirmActionBar [

	^ confirmActionBar
]

{ #category : #accessing }
ChestTableWithContentPresenter >> confirmButton [
	
	^ self confirmActionBar presenters first.
]

{ #category : #updating }
ChestTableWithContentPresenter >> defaultLayout [
	
	^ (SpPanedLayout newHorizontal
						    add: chestTableContainer;
						    add: chestContentTableContainer;
						    yourself)
]

{ #category : #updating }
ChestTableWithContentPresenter >> eventChestRemoved: aChest [
	self updateChestsTable
]

{ #category : #updating }
ChestTableWithContentPresenter >> eventContentOfChest: aChest updatedTo: newContents [
	| currentlySelectedChest |
	currentlySelectedChest := chestsTable selectedItem.
	currentlySelectedChest == aChest ifTrue: [ 
		self updateChestContentTableForChest: aChest ]
]

{ #category : #updating }
ChestTableWithContentPresenter >> eventNewChest: aChest [
	self updateChestsTable
]

{ #category : #updating }
ChestTableWithContentPresenter >> initialize [
	super initialize.
	Chest subscribeToUpdates: self
]

{ #category : #initialization }
ChestTableWithContentPresenter >> initializePresenters [

	chestsTable := self makeChestsTable.
	chestTableContainer := SpBoxLayout newVertical
		                       add: self chestsTable;
		                       yourself.
	chestContentsTable := self makeChestContentsTable.
	chestContentTableContainer := SpBoxLayout newVertical
		                              add: self chestContentTable ;
		                              yourself.
	chestsTable selectIndex: 1.
	inputField := self makeInputField.
	confirmActionBar := self makeConfirmActionBar.

	self layout: self defaultLayout
]

{ #category : #accessing }
ChestTableWithContentPresenter >> inputField [

	^ inputField
]

{ #category : #initialization }
ChestTableWithContentPresenter >> makeChestContentsTable [

	^ self newTable
		  addColumn: ((SpStringTableColumn
				    title: 'Name'
				    evaluated: [ :association | association key ]) width: 40);
		  addColumn: (SpStringTableColumn
				   title: 'Object'
				   evaluated: [ :association | association value asString ]);
"		  enableSearch;"
		  items: OrderedCollection new
]

{ #category : #initialization }
ChestTableWithContentPresenter >> makeChestsTable [

	^ self newList
		  items: Chest allChests;
		  display: [ :chest | chest name ];
		  transmitDo: [ :aChest | 
			  aChest ifNotNil: [ 
					  self updateChestContentTableForChest: aChest.
					  chestContentsTable items ifNotEmpty: [ 
							  chestContentsTable selectIndex: 1 ] ] ];
		  sortingBlock: [ :chest1 :chest2 | chest1 name < chest2 name ];
		  yourself
]

{ #category : #'as yet unclassified' }
ChestTableWithContentPresenter >> makeConfirmActionBar [

	^ self newActionBar
		  add: (self newButton
				   label: 'Confirm';
				   yourself);
		  add: (self newButton
				   label: 'Cancel';
					action: [ self window close ];
				   yourself);
		  yourself
]

{ #category : #'as yet unclassified' }
ChestTableWithContentPresenter >> makeInputField [

	^ self newTextInput
		  placeholder: 'Choose a name for your object';
		  text:
			  (chestsTable selectedItem nextDefaultNameForObject ifNil: [ '' ]);
		  yourself
]

{ #category : #accessing }
ChestTableWithContentPresenter >> title [

	^ 'Choose a variable name for your object'
]

{ #category : #initialization }
ChestTableWithContentPresenter >> updateChestContentTableForChest: aChest [
	chestContentsTable ifNotNil: [ :lst | lst items: aChest contents associations asOrderedCollection ]
]

{ #category : #updating }
ChestTableWithContentPresenter >> updateChestsTable [
	chestsTable ifNotNil: [ :lst | lst items: Chest allChests ]
]

{ #category : #'as yet unclassified' }
ChestTableWithContentPresenter >> warningNamingObjectInChest: newObjectName [

	^ '`' , newObjectName
	  ,
	  '` is the name of an object that already exists in this chest. If you proceed, this object in the existing chest will be removed and lost. Are you sure you want to proceed?'
]
