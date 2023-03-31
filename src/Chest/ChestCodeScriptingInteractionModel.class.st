Class {
	#name : #ChestCodeScriptingInteractionModel,
	#superclass : #StPlaygroundInteractionModel,
	#instVars : [
		'debugger'
	],
	#category : #Chest
}

{ #category : #accessing }
ChestCodeScriptingInteractionModel class >> debugger: aStDebugger [

	^ self new
		  debugger: aStDebugger;
		  yourself
]

{ #category : #binding }
ChestCodeScriptingInteractionModel >> addBinding: aBinding [

	super addBinding: aBinding.
	
	debugger ifNotNil: [ debugger interactionModel addBinding: aBinding ]
]

{ #category : #'private - bindings' }
ChestCodeScriptingInteractionModel >> addSelfAndThisContextBindings [

	| debuggerInteractionModel |
	debuggerInteractionModel := debugger interactionModel.

	super
		addBinding: (WorkspaceVariable
				 key: #self
				 value: debuggerInteractionModel doItReceiver);
		addBinding: (WorkspaceVariable
				 key: #thisContext
				 value: debuggerInteractionModel doItContext)
]

{ #category : #binding }
ChestCodeScriptingInteractionModel >> bindingOf: aString [

	| key |
	key := aString asSymbol.
	"prevent the case when a tool (like completion) asks for a global binding"
	(self class bindingOf: key) ifNotNil: [ :aBinding | ^ aBinding ].
	"Look in shared"
	(self sharedBindings includesKey: key) ifTrue: [ 
		^ self sharedBindings associationAt: key ].
	"Look in debugger code interaction model"
	(debugger isNotNil and: [ 
		 debugger interactionModel hasBindingOf: aString ]) ifTrue: [ 
		^ debugger interactionModel bindingOf: aString ].
	"if there is no binding, I will include a key"
	(self localBindings includesKey: key) ifFalse: [ 
		self addBinding: (WorkspaceVariable key: key) ].
	^ self localBindings associationAt: key
]

{ #category : #binding }
ChestCodeScriptingInteractionModel >> bindings [

	"Combining shared bindings and local bindings needs to be done like this because the 
	 #add: method of Dictionary stores the whole association (which in this case is a 
	 WorkspaceVariable and we need that. #at:put: cannot be used because it will create 
	 an Association and want to keep the WorkspaceVariable."

	| joinedBindings |
	"just a small optimisation"
	self application sharedBindings ifEmpty: [ ^ self localBindings ].

	joinedBindings := self application sharedBindings copy.

	debugger ifNotNil: [ 
		debugger bindings associations do: [ :each | 
			joinedBindings add: each ].
		^ joinedBindings ].

	self localBindings associations do: [ :each | 
		joinedBindings add: each ].

	^ joinedBindings
]

{ #category : #accessing }
ChestCodeScriptingInteractionModel >> debugger: aStDebugger [

	debugger := aStDebugger.
	
	self addSelfAndThisContextBindings.
	debugger code whenInteractionModelChangedDo: [ self addSelfAndThisContextBindings ]
]

{ #category : #binding }
ChestCodeScriptingInteractionModel >> hasBindingOf: aString [

	^ (self sharedBindings includesKey: aString asSymbol) or: [ 
		  (self localBindings includesKey: aString asSymbol) or: [ 
			  debugger isNotNil and: [ 
				  debugger interactionModel hasBindingOf: aString ] ] ]
]

{ #category : #accessing }
ChestCodeScriptingInteractionModel >> removeBinding: aBinding [

	self bindings removeKey: aBinding key.

	debugger ifNotNil: [ 
		debugger bindings removeKey: aBinding key ]
]
