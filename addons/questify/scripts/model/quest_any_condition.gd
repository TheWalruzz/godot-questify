class_name QuestAnyCondition extends QuestNode
	
	
func get_completed() -> bool:
	return any_previous_nodes_completed()
	
	
func update() -> void:
	if not get_completed():
		for node in previous:
			node.update()
			if node.get_completed():
				break
