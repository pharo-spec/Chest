Extension { #name : #SpCodePresenter }

{ #category : #'*Chest-Commands' }
SpCodePresenter class >> buildChestCommandsGroupWith: aCodePresenter forRoot: rootCommandGroup [
	<extensionCommands>
	ChestCommandTreeBuilder buildCommandsGroupWith: aCodePresenter forRoot: rootCommandGroup 
]
