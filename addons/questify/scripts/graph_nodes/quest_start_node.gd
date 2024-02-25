@tool
class_name QuestStartNode extends QuestGraphNode


var quest_name: String
var quest_description: String


@export var name_text_edit: LineEdit
@export var description_text_edit: TextEdit


func _get_model() -> QuestNode:
	return QuestStart.new()
	
	
func _set_model_properties(node: QuestNode) -> void:
	node.name = quest_name
	node.description = quest_description
	
	
func _get_model_properties(node: QuestNode) -> void:
	quest_name = node.name
	name_text_edit.text = node.name
	quest_description = node.description
	description_text_edit.text = node.description


func _on_name_text_changed(new_text: String) -> void:
	quest_name = new_text


func _on_description_text_changed() -> void:
	quest_description = description_text_edit.text
