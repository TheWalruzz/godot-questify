@tool
class_name QuestGraphNode extends GraphNode


@export var label_color: Color = Color.WHITE


var id: String
var has_loaded_position := false


func _ready() -> void:
	var title_label := get_titlebar_hbox().get_children()[0] as Label
	title_label.add_theme_color_override("font_color", label_color)


func get_model() -> QuestNode:
	var node := _get_model()
	node.id = id
	node.graph_editor_position = position_offset
	_set_model_properties(node)
	return node
	
	
func load_model(node: QuestNode) -> void:
	id = node.id
	position_offset = node.graph_editor_position
	has_loaded_position = true
	_get_model_properties(node)


func _get_model() -> QuestNode:
	return null
	
	
func _set_model_properties(_node: QuestNode) -> void:
	pass
	
	
func _get_model_properties(_node: QuestNode) -> void:
	pass
