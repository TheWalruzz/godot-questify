@tool
class_name QuestAnyPreviousNode extends QuestGraphNode


func _get_model() -> QuestNode:
	return QuestAnyPrevious.new()
	
