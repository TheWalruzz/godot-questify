class_name DataManager extends Node


signal data_changed(key: String, value: Variant)
signal reset_requested


var data := {}


func _ready() -> void:
	Questify.condition_query_requested.connect(
		func(type: String, key: String, value: Variant, requester: QuestCondition):
			if type == "variable":
				if get_value(key) == value:
					requester.set_completed(true)
	)


func set_value(key: String, value: Variant) -> void:
	data[key] = value
	data_changed.emit(key, value)
	
	
func get_value(key: String) -> Variant:
	if data.has(key):
		return data[key]
	return null
	
	
func clear() -> void:
	data.clear()
	reset_requested.emit()
