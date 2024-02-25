class_name QuestCondition extends QuestNode


enum ValueType {
	BOOLEAN,
	STRING,
	INTEGER,
}


@export var type: String
@export var key: String
@export var value_type: ValueType
@export var bool_value: bool
@export var string_value: String
@export var int_value: int


var value: Variant:
	get:
		match value_type:
			ValueType.BOOLEAN:
				return bool_value
			ValueType.STRING:
				return string_value
			ValueType.INTEGER:
				return int_value
		return null


func update() -> void:
	if not get_completed():
		Questify.condition_query_requested.emit(type, key, value, self)


func set_completed(new_value: bool) -> void:
	completed = new_value
