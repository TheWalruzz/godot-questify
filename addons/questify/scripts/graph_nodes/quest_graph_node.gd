@tool
class_name QuestGraphNode extends GraphNode


var id: String
var has_loaded_position := false


func _ready() -> void:
	var delete_button: Button = Button.new()
	var node_name_array: Array[StringName] = [name]
	delete_button.icon = get_theme_icon("Close", "EditorIcons")
	delete_button.pressed.connect(get_parent()._on_delete_nodes_request.bind(node_name_array))
	delete_button.size_flags_horizontal = SIZE_SHRINK_END
	get_titlebar_hbox().add_child(delete_button)


func get_model() -> QuestNode:
	var node := _get_model()
	node.id = id
	node.graph_editor_position = position_offset
	if not size.is_zero_approx():
		node.graph_editor_size = size
	_set_model_properties(node)
	return node
	
	
func load_model(node: QuestNode) -> void:
	id = node.id
	position_offset = node.graph_editor_position
	if not node.graph_editor_size.is_zero_approx():
		size = node.graph_editor_size
	has_loaded_position = true
	_get_model_properties(node)


func _get_model() -> QuestNode:
	return null
	
	
func _set_model_properties(_node: QuestNode) -> void:
	pass
	
	
func _get_model_properties(_node: QuestNode) -> void:
	pass
	
