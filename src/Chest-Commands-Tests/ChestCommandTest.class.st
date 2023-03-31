Class {
	#name : #ChestCommandTest,
	#superclass : #TestCase,
	#instVars : [
		'initialChests'
	],
	#category : #'Chest-Commands-Tests'
}

{ #category : #running }
ChestCommandTest >> setUp [

	super setUp.
	initialChests := Chest allChests copy "Keep a copy of all the chests that currently exist"
]

{ #category : #running }
ChestCommandTest >> tearDown [

	| nowChests |
	nowChests := Chest allChests copy.
	"Removing chests that currently exist but did not exist before the test execution"
	nowChests do: [ :aChest |
		(initialChests includes: aChest) ifFalse: [
			Chest removeChest: aChest ] ]
]
