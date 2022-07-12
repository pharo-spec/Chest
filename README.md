# Chest
Chest allows you to store objects from anywhere, to keep them around to check equality...   

![ChestOverview](https://user-images.githubusercontent.com/32486709/62879133-bf767b80-bd2a-11e9-94a2-4fb00a986740.png)
  
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

##### How to create instances 
- `Chest class>>#new` : creates a chest with a default name that is in the form of 'Chest_autoIncrementedNumber'

- `Chest class>>#newNamed:` : creates a chest with the name given in parameter if no other chest is already named so, else `ChestKeyAlreadyInUseError`

