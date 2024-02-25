@tool
class_name QuestAnyConditionNode extends QuestGraphNode


func _get_model() -> QuestNode:
	return QuestAnyCondition.new()
