# Chest

![ChestOverview](image.png)
  
![ChestPicture2](https://user-images.githubusercontent.com/32486709/62878741-f9934d80-bd29-11e9-93dd-5969fbf6de72.png)

## Open your Chest
Chest is available in the **world menu** of Pharo.
![image](https://user-images.githubusercontent.com/32486709/59115077-cce94100-8948-11e9-85c6-903d459b89ae.png)

You can also enable it as a debugger extension in the debugging settings of Pharo.

## Install Chest
```smalltalk
Metacello new
    baseline: 'Chest';
    repository: 'github://adri09070/Chest';
    load.
```
*Will load [Spec](https://github.com/pharo-spec/Spec) and [New Tools](https://github.com/pharo-spec/NewTools)*

## More Details
### Name (= ID)
Each Chest instance has an ID (String). These IDs are unique. Two chests cannot have the same ID.

### Default Chest
This is an instance of Chest can be interacted with in the same way as any other Chest by sending the messages to the Chest class.

### Commands in context

### API
```
	Chest class
		#new
			Create and return a new Chest
		#newNamed: aString
			Create and return a new Chest, with the provided name
		#withId: anInteger
			Return the Chest whose ID is @anInteger

	Chest instance
		#add: anObject
			Add anObject to this Chest
		#at: anInteger
			Gets the object stored in this Chest at index @anInteger
		#contents
			Gets an OrderedCollection with the content of this Chest. This collection is a copy so editing it directly does not affect this Chest.
		#empty
			Removes all objects from this Chest
		#name
			Gets the name of this Chest
		#id
			Gets the ID of this Chest
		#remove
			Destroy this Chest (it will no longer appear in the Chest UI)
		#remove: anObject
			Remove @anObject from this Chest
		#removeAt: anInteger
			Remove the object ar index @anInteger from this Chest
```
