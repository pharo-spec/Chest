Extension { #name : #SpTreeTablePresenter }

{ #category : #'*Chest' }
SpTreeTablePresenter >> parentOfSelected [

	| parentPath |
	parentPath := self selection selectedPath.
	parentPath ifEmpty: [ ^ nil ].
	parentPath := parentPath allButLast.
	^ self itemAtPath: parentPath ifAbsent: nil
]
