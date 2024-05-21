Class {
	#name : 'ChestPasteLoadCommandTest',
	#superclass : 'ChestCommandTest',
	#category : 'Chest-Commands-Tests',
	#package : 'Chest-Commands-Tests'
}

{ #category : 'tests' }
ChestPasteLoadCommandTest >> testBuildInjectedCode [

	| chest obj command code |
	chest := Chest new.
	obj := Object new.
	command := ChestPasteLoadCodeCommand new
		           chestName: chest name;
		           objectName: 'titi';
		           yourself.
	chest at: 'titi' put: obj.

	code := command buildInjectedCode.

	self
		assert: (OpalCompiler new
				 source: code;
				 evaluate)
		identicalTo: obj
]
