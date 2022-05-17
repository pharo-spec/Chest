Class {
	#name : #ChestTableWithContentPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'chestsTable',
		'chestContentsTable'
	],
	#category : #Chest
}

{ #category : #updating }
ChestTableWithContentPresenter >> chestContentTable [

	^ chestContentsTable
]

{ #category : #updating }
ChestTableWithContentPresenter >> chestsTable [

	^ chestsTable
]

{ #category : #updating }
ChestTableWithContentPresenter >> defaultLayout [
	
	^ (SpPanedLayout newHorizontal
						    add: (SpBoxLayout newVertical
								     add: #chestsTable;
								     yourself);
						    add: (SpBoxLayout newVertical
								     add: #chestContentsTable;
								     yourself);
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
	chestContentsTable := self makeChestContentsTable.
	chestsTable selectIndex: 1.
	
	self layout: self defaultLayout 
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

{ #category : #initialization }
ChestTableWithContentPresenter >> updateChestContentTableForChest: aChest [
	chestContentsTable ifNotNil: [ :lst | lst items: aChest contents associations asOrderedCollection ]
]

{ #category : #updating }
ChestTableWithContentPresenter >> updateChestsTable [
	chestsTable ifNotNil: [ :lst | lst items: Chest allChests ]
]
