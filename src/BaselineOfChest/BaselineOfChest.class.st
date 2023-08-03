Class {
	#name : #BaselineOfChest,
	#superclass : #BaselineOf,
	#category : #BaselineOfChest
}

{ #category : #baselines }
BaselineOfChest >> baseline: spec [

	<baseline>
	spec for: #common do: [
		spec postLoadDoIt: #postload:package:.

		spec
			package: 'Chest';
			package: 'Chest-Tests';
			package: 'Chest-Commands';
			package: 'Chest-Commands-Tests' ].

	spec
		group: 'default'
		with:
		#( 'Chest' 'Chest-Commands' 'Chest-Tests' 'Chest-Commands-Tests' )
]

{ #category : #baselines }
BaselineOfChest >> createChestExamples [

	Chest at: 'fortyTwo' put: 42.
	(Chest newNamed: 'ExampleChest')
		at: 'tata'
		put: 'someExampleStringCalledTata'
]

{ #category : #baselines }
BaselineOfChest >> postload: loader package: packageSpec [

	self createChestExamples
]
