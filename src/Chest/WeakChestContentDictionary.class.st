"
I'm a dictionary used by `WeakChest` to keep weak references to objects a weak chest contains.
"
Class {
	#name : 'WeakChestContentDictionary',
	#superclass : 'ChestContentDictionary',
	#category : 'Chest-Model',
	#package : 'Chest',
	#tag : 'Model'
}

{ #category : 'accessing' }
WeakChestContentDictionary class >> associationClass [

	^ WeakChestAssociation
]
