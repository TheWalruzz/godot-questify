class_name QuestEnd extends QuestNode


func get_active() -> bool:
	return all_previous_nodes_completed()
	
	
func get_completed() -> bool:
	return get_active()


func update() -> void:
	if get_completed():
		_graph.complete_quest()
