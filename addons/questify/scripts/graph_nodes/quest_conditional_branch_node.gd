@tool
class_name QuestConditionalBranchNode extends QuestGraphNode


func _get_model() -> QuestNode:
	return QuestConditionalBranch.new()
