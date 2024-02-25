class_name QuestExclusiveBranchConnector extends QuestNode


func get_active() -> bool:
	return any_previous_nodes_completed()
	
	
func get_completed() -> bool:
	return get_active()
