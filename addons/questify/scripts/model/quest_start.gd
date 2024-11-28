class_name QuestStart extends QuestNode


@export var name: String
@export var description: String


var active: bool


func get_active() -> bool:
	return active
	
	
func get_completed() -> bool:
	return active


func serialize() -> Dictionary:
	return {
		id = id,
		completed = get_completed(),
		active = active
	}
	
	
func deserialize(data: Dictionary) -> void:
	id = data.id
	completed = data.completed
	active = data.active
