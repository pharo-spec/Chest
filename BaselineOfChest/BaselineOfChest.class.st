Class {
	#name : #BaselineOfChest,
	#superclass : #BaselineOf,
	#category : #BaselineOfChest
}

{ #category : #baselines }
BaselineOfChest >> baseline: spec [

	<baseline>
	spec for: #common do: [
		spec
			package: 'Chest';
			package: 'Chest-Tests';
			package: 'Chest-Commands' ].

	spec
		group: 'default'
		with: #( 'Chest' 'Chest-Commands' 'Chest-Tests' )
]
