class_name QuestAnyPrevious extends QuestNode
	
	
func get_completed() -> bool:
	return any_previous_nodes_completed()
