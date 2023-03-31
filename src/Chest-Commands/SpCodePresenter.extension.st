Extension { #name : #SpCodePresenter }

{ #category : #'*Chest-Commands' }
SpCodePresenter class >> buildChestCommandsGroupWith: aCodePresenter forRoot: rootCommandGroup [
	<extensionCommands>
	ChestCommandTreeBuilder buildCommandsGroupWith: aCodePresenter forRoot: rootCommandGroup 
]

{ #category : #'*Chest-Commands' }
SpCodePresenter >> canLoadBindings [

	^ self interactionModel canLoadBindings
]
