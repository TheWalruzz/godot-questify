@tool
class_name QuestNotConditionNode extends QuestGraphNode


func _get_model() -> QuestNode:
	return QuestNotCondition.new()
