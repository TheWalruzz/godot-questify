# Questify

A graph-based quest editor and manager for Godot 4.

![Example quest graph](docs/main.png)

# Usage

## Installation

1. Copy addons/questify directory to you addons directory.
2. Enable Questify plugin.
3. Restart the editor.
4. It's done! You can access the editor screen by clicking on the *Questify* button in the top of the editor.

## Basics

Each quest resource is composed of graph nodes. Quest should have exactly one Start Node and one End Node, to which all paths should converge.

### Creating/editing a quest

A new quest can be created in the Questify tab by clicking on the new file icon, clicking on load button or by double-clicking an existing quest resource in the FileSystem tab in Godot.

You can add nodes to the graph by either using an Add button in the top or by right-clicking anywhere in the graph plane.

Questify also handles undo/redo for most actions, like pasting and deleting.

### Starting the quest

In order to start the quest in your code, you have to load the `QuestResource` you have created and instantiate it. This is done to ensure no modification to the original resource was done. Then, you can simply start it using `Questify` singleton like this:

```gdscript
@export var quest: QuestResource

func _ready() -> void:
  var instance := quest.instantiate()
  Questify.start_quest(instance)
```

### Observing quest states

Questify singleton exposes several signals to keep track of active quests.

```gdscript
signal quest_started(quest: QuestResource)
signal quest_objective_added(quest: QuestResource, objective: QuestObjective)
signal quest_objective_completed(quest: QuestResource, objective: QuestObjective)
signal quest_completed(quest: QuestResource)
```

`quest_started` is emitted every time a new quest is started.

`quest_objective_added` is emitted every time a new objective becomes active.

`quest_objective_completed` is emitted when objective is completed and becomes inactive.

`quest_completed` is emitted when quest is finished, i.e. end node has completed.

### Handling condition queries

Questify uses an architecture-agnostic query system to handle quest conditions. This is due to some of the limitations of Godot plugins, but has some advantages. This way Questify can be setup without much work on your part.

Each Condition Node from an active objective will periodically send a query request via its signal. It's up to you to handle each type, key and value.

Check interval is 0.5 seconds by default, but can be changed in `Project Settings -> Questify -> General -> Update Interval`.

This signal has following signature:

```gdscript
signal condition_query_requested(type: String, key: String, value: Variant, requester: QuestCondition)
```

As an example, you can setup this simple handler somewhere in your DataManager and quests will be updated properly:

```gdscript
Questify.condition_query_requested.connect(
  func(type: String, key: String, value: Variant, requester: QuestCondition):
    if type == "variable":
      if get_value(key) == value:
        requester.set_completed(true)
)
```

Of course, you might need to use more operators than equality in queries, but this can be easily done by handling different subtypes of query type string, making for a quite elaborate and powerful system. For example, it could look like this in your DataManager or equivalent class:

```gdscript
Questify.condition_query_requested.connect(
  func(type: String, key: String, value: Variant, requester: QuestCondition):
    if type.begins_with("var"):
      var operator := type.get_slice(":", 1)
      var variable := get_value(key)
      var result := false
      match operator:
        type, "eq", "==":
          result = variable == value
        "neq", "ne", "!eq", "!=":
          result = variable != value
        "lt", "<":
          assert(not variable is bool, "Incorrect variable type for quest condition query operator")
          result = variable < value
        "lte", "<=":
          assert(not variable is bool, "Incorrect variable type for quest condition query operator")
          result = variable <= value
        "gt", ">":
          assert(not variable is bool, "Incorrect variable type for quest condition query operator")
          result = variable > value
        "gte", ">=":
          assert(not variable is bool, "Incorrect variable type for quest condition query operator")
          result = variable >= value
        _:
          printerr("Unknown operator '%s' in quest condition query" % operator)
      requester.set_completed(result)
)
```

In the example above, you can now use more complex query types, like: `var`, `var:>`, `variable:lte` etc.

Additionally, condition checks can be paused when necessary (e.g. when the game is paused):

```gdscript
Questify.toggle_quest_check(false)
```

### Serialization and deserialization
For most cases, Questify can holisitically serialize and deserialize state of current quests using methods provided to the autoload:

```gdscript
var serialized_state := Questify.serialize() # returns Array
Questify.deserialize(serialized_state)
```

All the saved quests will be instantiated and deserialized immediately.

If you need to serialize/deserialize quests on your own, quest state can be serialized to a `Dictionary` using `serialize()` and `deserialize()` methods provided by `QuestResource`. However, to be deserialized, quests have to be instantiated from the original resource and then added to the Questify singleton manually. This can be done by passing an array of deserialized quests to Questify. This could look like this:

```gdscript
# before saving
for quest_instance in quests:
	var serialized_quest := quest_instance.serialize() # returns Dictionary
	# getting resource path using this method is necessary, since instances do not have `resource_path` property
	var quest_path = quest_instance.get_resource_path()
	# ...do other serialization stuff

# after loading
var quests: Array[QuestResource] = []
for quest in serialized_quests:
	# ...load proper quest resource
	var instance := quest.instantiate()
	instance.deserialize(quest.data) # quest.data could be whatever property you use to store the serialized data
	quests.append(instance)
Questify.set_quests(quests)
```

And that's it!

# Quest Nodes

Nodes have two internal states:

* `active`
* `completed`

## Active state

Active state marks the node as active and processable. For example, active state in Start Node means that the quest was started and the system can process its child nodes. Most nodes will retain their active state once they become active, with a major exception for objective node. Objective will become inactive when completed. Also, condition nodes do not use active state in general, since they're only active when connected objective is active.

## Completed state

Completed state means that the node has passed all the conditions and won't be processed anymore. Each node has its own rules for being completed. However, most importantly, objectives can only become completed if all of the attached condition nodes become completed (i.e. conditions are true).

## Available nodes

### Start Node

The entry point of any quest. There can be only exactly one in each quest.

### End Node

The node marking the end (and completion) of a quest. There should be only one in quest.

### TODO