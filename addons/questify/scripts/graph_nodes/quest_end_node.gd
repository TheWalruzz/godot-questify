@tool
class_name QuestEndNode extends QuestGraphNode


func _get_model() -> QuestNode:
	return QuestEnd.new()
