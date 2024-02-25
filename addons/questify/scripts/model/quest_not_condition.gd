class_name QuestNotCondition extends QuestNode


func get_completed() -> bool:
	return not all_previous_nodes_completed()


func update() -> void:
	if not get_completed():
		for node in previous:
			node.update()
