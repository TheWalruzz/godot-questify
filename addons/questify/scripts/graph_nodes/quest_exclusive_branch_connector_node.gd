@tool
class_name QuestExclusiveBranchConnectorNode extends QuestGraphNode


func _get_model() -> QuestNode:
	return QuestExclusiveBranchConnector.new()
