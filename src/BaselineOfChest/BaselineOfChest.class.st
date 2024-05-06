Class {
	#name : 'BaselineOfChest',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfChest',
	#package : 'BaselineOfChest'
}

{ #category : 'baselines' }
BaselineOfChest >> baseline: spec [

	<baseline>
	spec for: #common do: [
		spec postLoadDoIt: #postload:package:.
		
		spec
			package: 'Chest';
			package: 'Chest-Tests' with: [ spec requires: #( 'Chest' ) ];
			package: 'Chest-Commands' with: [ spec requires: #( 'Chest' ) ];
			package: 'Chest-Commands-Tests'
			with: [ spec requires: #( 'Chest-Commands' ) ] ].

	spec
		group: 'default'
		with:
		#( 'Chest' 'Chest-Commands' 'Chest-Tests' 'Chest-Commands-Tests' )
]

{ #category : 'baselines' }
BaselineOfChest >> createChestExamples [

	| chestClass |
	chestClass := self class environment at: #Chest ifAbsent: [ ^ self ].
	chestClass at: 'fortyTwo' put: 42.
	(chestClass newNamed: 'ExampleChest')
		at: 'tata'
		put: 'someExampleStringCalledTata'
]

{ #category : 'baselines' }
BaselineOfChest >> postload: loader package: packageSpec [

	self createChestExamples
]
