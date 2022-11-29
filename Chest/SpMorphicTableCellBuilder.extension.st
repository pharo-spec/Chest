Extension { #name : #SpMorphicTableCellBuilder }

{ #category : #'*Chest' }
SpMorphicTableCellBuilder >> visitChestInputFieldColumn: aChestInputFieldColumn [

	| presenter morph |
	presenter := SpTextInputFieldPresenter new
		             maxLength: aChestInputFieldColumn maxLength;
		             placeholder: aChestInputFieldColumn placeholder;
		             text: (aChestInputFieldColumn readObject: self item);
		             "color: Color darkGray;"
		             addStyle: 'table';
		             yourself.

	morph := presenter build.
	presenter adapter applyStyle: morph.

	self addCellMorph: morph column: aChestInputFieldColumn
]
