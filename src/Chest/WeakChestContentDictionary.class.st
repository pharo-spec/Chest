"
I'm a dictionary used by `WeakChest` to keep weak references to objects a weak chest contains.
"
Class {
	#name : #WeakChestContentDictionary,
	#superclass : #ChestContentDictionary,
	#category : #Chest
}

{ #category : #accessing }
WeakChestContentDictionary class >> associationClass [

	^ WeakChestAssociation
]
