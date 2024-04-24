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
		spec
			package: 'Chest';
			package: 'Chest-Tests' with: [ spec requires: #( 'Chest' ) ];
			package: 'Chest-Commands' with: [ spec requires: #( 'Chest' ) ];
			package: 'Chest-Commands-Tests' with: [ spec requires: #( 'Chest-Commands' ) ]].

	spec
		group: 'default'
		with:
		#( 'Chest' 'Chest-Commands' 'Chest-Tests' 'Chest-Commands-Tests' )
]
