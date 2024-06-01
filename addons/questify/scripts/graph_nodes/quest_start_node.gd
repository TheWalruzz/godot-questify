@tool
class_name QuestStartNode extends QuestGraphNode


var quest_name: String
var quest_description: String


@export var name_text_edit: LineEdit
@export var description_text_edit: TextEdit
@export var metadata_editor: MetadataEditor


func _get_model() -> QuestNode:
	return QuestStart.new()
	
	
func _set_model_properties(node: QuestNode) -> void:
	node.name = quest_name
	node.description = quest_description
	for key in get_meta_list():
		node.set_meta(key, get_meta(key))
	
	
func _get_model_properties(node: QuestNode) -> void:
	quest_name = node.name
	name_text_edit.text = node.name
	quest_description = node.description
	description_text_edit.text = node.description
	for key in node.get_meta_list():
		set_meta(key, node.get_meta(key))
	metadata_editor.update()


func _on_name_text_changed(new_text: String) -> void:
	quest_name = new_text


func _on_description_text_changed() -> void:
	quest_description = description_text_edit.text
