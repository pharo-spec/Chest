Extension { #name : #StDebuggerExtensionInspectorNodeBuilderVisitor }

{ #category : #'*Chest' }
StDebuggerExtensionInspectorNodeBuilderVisitor >> visitChest: aChestExtension [

	| debuggerInteractionModel |
	debuggerInteractionModel := aChestExtension debugger interactionModel.
	result := debuggerInteractionModel bindings associations
		          select: [ :aBinding | 
			          aBinding propertyAt: #comesFromChest ifAbsent: [ false ] ]
		          thenCollect: [ :chestVariable | 
			          (StInspectorDynamicNode
				           hostObject: chestVariable value
				           label: chestVariable key
				           value: chestVariable value)
				          variableTag: 'Chest';
				          yourself ]
]
