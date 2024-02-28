@tool
class_name QuestGraphNode extends GraphNode


var id: String
var has_loaded_position := false


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
