class_name QuestStart extends QuestNode


@export var name: String
@export var description: String


var active: bool


func get_active() -> bool:
	return active
	
	
func get_completed() -> bool:
	return active


func serialize() -> Dictionary:
	var data := super()
	data.active = active
	return data
	
	
func deserialize(data: Dictionary) -> void:
	super(data)
	active = data.active
