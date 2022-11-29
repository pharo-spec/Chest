Class {
	#name : #ChestInputFieldTableColumn,
	#superclass : #SpTableColumn,
	#instVars : [
		'placeholder',
		'text',
		'maxLength'
	],
	#category : #Chest
}

{ #category : #examples }
ChestInputFieldTableColumn class >> example [

	| tablePresenter |
	tablePresenter := SpTablePresenter new
		                  addColumn:
			                  (SpStringTableColumn
				                   title: 'Name'
				                   evaluated: #name);
		                  addColumn: ((self title: 'Variable Name')
				                   placeholder: 'Write on me';
				                   evaluated: [ :aClass | aClass name ];
				                   yourself);
		                  items: self class environment allClasses;
		                  beResizable;
		                  yourself.
	^ tablePresenter open
]

{ #category : #visiting }
ChestInputFieldTableColumn >> acceptColumnVisitor: aVisitor [

	aVisitor visitChestInputFieldColumn: self
]

{ #category : #initialization }
ChestInputFieldTableColumn >> initialize [

	super initialize.
	placeholder := 'Write on me'.
	text := ''.
	maxLength := 0
]

{ #category : #accessing }
ChestInputFieldTableColumn >> maxLength [

	^ maxLength
]

{ #category : #accessing }
ChestInputFieldTableColumn >> maxLength: anObject [

	maxLength := anObject
]

{ #category : #accessing }
ChestInputFieldTableColumn >> placeholder [

	^ placeholder
]

{ #category : #accessing }
ChestInputFieldTableColumn >> placeholder: anObject [

	placeholder := anObject
]

{ #category : #accessing }
ChestInputFieldTableColumn >> text [

	^ text
]

{ #category : #accessing }
ChestInputFieldTableColumn >> text: anObject [

	text := anObject
]
