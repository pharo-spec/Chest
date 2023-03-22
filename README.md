# Chest
Chest allows you to store objects from anywhere, to keep them around to check equality...   

<img width="798" alt="ChestOverview" src="https://user-images.githubusercontent.com/97704417/196198740-9df10993-b338-4c1d-862b-fe9dd7b188fb.png">
  

## Original repository

[Link to original repository](https://github.com/dupriezt/Chest)

## Install Chest
```smalltalk
Metacello new
    baseline: 'Chest';
    repository: 'github://pharo-spec/Chest';
    load.
```

## Open Chest
Chest is available in the **world menu** of Pharo.
![image](https://user-images.githubusercontent.com/97704417/196199178-587bbd99-6da8-404c-a953-81310f9993d7.png)


You can also enable it as a debugger extension in the debugging settings of Pharo:

![image](https://user-images.githubusercontent.com/97704417/196199391-8c3d3013-c57b-47dd-99f9-4d52ae0e9611.png)

## More Details
### Name (= ID)
Each Chest instance has an ID (String). These IDs are unique. Two chests cannot have the same ID.

### Default Chest
This is an instance of Chest can be interacted with in the same way as any other Chest by sending the messages to the Chest class.

### Commands in context

If you right-click on a code presenter with an `SpCodeInteractionModel` or `StDebuggerContextInteractionModel` (e.g: playground, inspector pane, debugger etc.), you can evaluate an expression and store the result in the chest of your choice, with the name of your choice:

![image](https://user-images.githubusercontent.com/97704417/196201016-6dfc0721-f9bc-4ce8-b35d-a3d4531ed425.png)

![image](https://user-images.githubusercontent.com/97704417/196201179-9abdabde-2eec-486d-aeb4-35f588cb6147.png)

![image](https://user-images.githubusercontent.com/97704417/196201295-ebccd118-4043-4e22-acd5-56d4dde0b0a9.png)

It's also possible to load objects from a chest into these code presenters:

![image](https://user-images.githubusercontent.com/97704417/196200344-bd410180-d7df-42c2-8f24-a09a9f0e9559.png)

![image](https://user-images.githubusercontent.com/97704417/196200215-5ab6e326-c2ef-4ce3-811f-b2e00303927e.png)

![image](https://user-images.githubusercontent.com/97704417/196200487-cda36d03-2d33-4b97-8d9d-212e103aed67.png).

And then variables can be seen from any other context if it has been loaded in a debugger and these variables can be seen in the debugger inspector:

![image](https://user-images.githubusercontent.com/97704417/196200800-a496e3fc-13c0-4329-b7d6-5036698e1f72.png)

Chest, as a debugger extension, provides a playground. All bindings between this playground and the debugger selected context are shared. So: all variables defined in this playground are recognized by the debugger and all variables from the debugger's selected context or loaded from Chest into the debugger are recognized by the playground. However, only the variables loaded from Chest are displayed in the debugger inspector.

### API

#### Chest instance API

- `Chest>>#add:` : adds the object in argument to the chest with a default name that is in the form of 'chestName_autoIncrementedNumber'

- `Chest>>#at: ` : gives the object in the chest whose name is the string in argument if it exists, else `KeyNotFound`

- `Chest>>#at:put:` : adds the object in second argument to the chest with the name in first argument if no other object is already named so, else `ChestKeyAlreadyInUseError`

- `Chest>>#contents` : gives a copy of a chest's contents as a dictionary

- `Chest>>#remove:` : removes the object in argument from a chest if it is there, else `KeyNotFound`

- `Chest>>#removeObjectNamed:` : removes the object whose name is in argument if it is there, else `ObjectNotInChestError`

The 6 messages above can be sent to `Chest class` unlike the ones below:

- `Chest>>#empty`: empties a chest.

- `Chest>>#remove` : completely deletes this chest

- `Chest>>#name` : gives this chest's name

- `Chest>>#name:` : renames this chest as the string in argument if no other chest is already named so, else `ChestKeyAlreadyInUseError`

- `Chest>>#renameObject:into:` : renames the object (first argument) in a chest as the string in second argument; if the object is in the chest else `ObjectNotInChestError` and if no other object is already named so else `ChestKeyAlreadyInUseError`

- `Chest>>#inspectAt` : inspect in a chest the object whose name is in argument

#### `Chest class` API

- `Chest class>>#allChests` : gives an ordered collection that contains all chests

- `Chest class>>#chestDictionary` : gives all chests with their names as a dictionary

- `Chest class>>#named:` : gives the chest that is named as the string in argument

- `Chest class>>#defaultInstance` ( or `Chest class>>#default`) : gives the default chest that is used when you use `Chest` API on `Chest class`

- `Chest class>>#inChest:at:put:` : puts an object with a given name in a chest of a given name that is created it it doesn;t exist yet.

- `Chest class>>#announcer` : helper that gives the unique instance of `ChestAnnouncer`

- `Chest class>>#unsubscribe:` : helper that unsubscribes its argument from the unique instance of `ChestAnnouncer`

- `Chest class>>#weak` : returns `WeakChest class`. You can use the same API on this class as you would on `Chest class`, in order to create or access chests that hold weak references to objects.

##### How to create instances 
- `Chest class>>#new` : creates a chest with a default name that is in the form of 'Chest_autoIncrementedNumber'

- `Chest class>>#newNamed:` : creates a chest with the name given in parameter if no other chest is already named so, else `ChestKeyAlreadyInUseError`

### Example

```smalltalk
	Chest new. "its name is 'Chest_1' if no other chest have been created before"
	Chest new. "its name is 'Chest_2' if no other chest have been created before"
	Chest newNamed: 'toto'. "its name is 'toto'"
	Chest newNamed: 'toto'. "ChestKeyAlreadyInUseError as a chest named 'toto' already exists"
	
	(Chest named: 'toto') add: 42.
	"42 has the key 'toto_1' in the chest named 'toto'"
	
	(Chest named: 'toto') at: 'toto' put: 42.
	(Chest named: 'toto') at: 'toto'. "returns 42"
	"42 has the key 'toto' and not 'toto_1' anymore as an object has a unique key in a chest."
	
	(Chest named: 'toto') at: 'toto' put: 72.
	"72 is not put in the chest: a ChestKeyAlreadyInUseError is raised as 42 already has the key 'toto'"
	
	(Chest named: 'toto') renameObject: 42 into: 'tata' .
	"42 has now the key 'tata' in the chest named 'toto'"
	
	(Chest named: 'toto') removeObjectNamed: 'tata'.
	"42 is removed as it had the key 'tata'"
	
	(Chest named: 'toto') at: 'toto' put: 72.
	(Chest named: 'toto') remove: 72. 
	"72 is not in the chest anymore"
	
	(Chest named: 'toto') remove: 72. "KeyNotFound"
	(Chest named: 'toto') renameObject: 72 into: 'toto'. "ObjectNotInChestError"
	(Chest named: 'toto') removeObjectNamed: 'toto'. "ObjectNotInChestError"
	
	(Chest named: 'toto') 	at: 'toto' put: 42;
									at: 'tata' put: 72;
									renameObject: 42 into: 'tata'. "ChestKeyAlreadyInUseError"
	
	(Chest named: 'toto') contents at: 'tata' "returns 72"
							
	Chest defaultInstance	name: 'toto' "ChestKeyAlreadyInUseError"					
	
	(Chest named: 'toto') remove.
	"deletes the chest named 'toto', and all objects inside"
	
	Chest named: 'toto'. "KeyNotFound"
	Chest defaultInstance name: 'toto'. "the default chest is now named 'toto'"
	
	Chest defaultInstance remvove. "the default chest is still there as it can't be removed"
	
	Chest add: 42. "adds 42 to the default chest"
	
	Chest inChest: 'titi' at: 'tata' put: 42. "creates the chest named 'titi' as it doesn't exist, and put 42 in it with the name 'tata' "
	
	Chest inChest: 'titi' at: 'toto' put: 43. "puts 43 in the chest named 'titi' with the name 'toto'"
	
	Chest weak inChest: 'wtiti' at: 'tata' put: 42 "puts 42 in the weak chest named 'wtiti' with the name 'tata'"
```
