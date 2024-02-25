@tool
class_name QuestConditionNode extends QuestGraphNode


var type: String
var key: String
var value_type: QuestCondition.ValueType = QuestCondition.ValueType.BOOLEAN
var value: Variant


@export var type_input: LineEdit
@export var key_input: LineEdit
@export var tab_container: TabContainer
@export var boolean_value: CheckBox
@export var string_value: LineEdit
@export var integer_value: SpinBox


func _get_model() -> QuestNode:
	return QuestCondition.new()
	
	
func _set_model_properties(node: QuestNode) -> void:
	node.type = type
	node.key = key
	node.value_type = value_type
	match value_type:
		QuestCondition.ValueType.BOOLEAN:
			node.bool_value = value == true
		QuestCondition.ValueType.STRING:
			node.string_value = value
		QuestCondition.ValueType.INTEGER:
			node.int_value = value
	
	
func _get_model_properties(node: QuestNode) -> void:
	type = node.type
	type_input.text = node.type
	key = node.key
	key_input.text = node.key
	value_type = node.value_type
	tab_container.current_tab = node.value_type
	match node.value_type:
		QuestCondition.ValueType.BOOLEAN:
			value = node.bool_value
			boolean_value.button_pressed = node.bool_value
		QuestCondition.ValueType.STRING:
			value = node.string_value
			string_value.text = node.string_value
		QuestCondition.ValueType.INTEGER:
			value = node.int_value
			integer_value.set_value_no_signal(node.int_value)


func _on_type_text_changed(new_text: String) -> void:
	type = new_text


func _on_key_text_changed(new_text: String) -> void:
	key = new_text


func _on_tab_selected(tab: int) -> void:
	if tab != value_type:
		value_type = tab as QuestCondition.ValueType
		value = null


func _on_boolean_toggled(toggled_on: bool) -> void:
	value = toggled_on


func _on_string_text_changed(new_text: String) -> void:
	value = new_text


func _on_integer_value_changed(input_value: float) -> void:
	value = input_value
