class_name QuestCondition extends QuestNode


enum ValueType {
	BOOLEAN,
	STRING,
	INTEGER,
}


@export var type: String
@export var key: String


var value: Variant:
	get: return get_meta("value")


func update() -> void:
	if not get_completed():
		Questify.condition_query_requested.emit(type, key, value, self)


func set_completed(new_value: bool) -> void:
	completed = new_value
