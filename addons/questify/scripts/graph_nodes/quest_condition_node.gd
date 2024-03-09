@tool
class_name QuestConditionNode extends QuestGraphNode


var type: String
var key: String
var value: Variant


@export var type_input: LineEdit
@export var key_input: LineEdit
@export var meta_input: VariantInput


func _get_model() -> QuestNode:
	return QuestCondition.new()
	
	
func _set_model_properties(node: QuestNode) -> void:
	node.type = type
	node.key = key
	node.set_meta("value", value)
	
	
func _get_model_properties(node: QuestNode) -> void:
	type = node.type
	type_input.text = node.type
	key = node.key
	key_input.text = node.key
	value = node.get_meta("value", false)
	meta_input.set_value(value)


func _on_type_text_changed(new_text: String) -> void:
	type = new_text


func _on_key_text_changed(new_text: String) -> void:
	key = new_text


func _on_metadata_input_value_changed(new_value: Variant) -> void:
	value = new_value
