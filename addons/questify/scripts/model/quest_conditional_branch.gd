class_name QuestConditionalBranch extends QuestNode


var conditions: Array[QuestNode]:
	get:
		return _graph.get_previous_nodes(self, QuestEdge.EdgeType.CONDITIONAL)


func get_active() -> bool:
	return all_previous_nodes_completed()
	
	
func update() -> void:
	if get_active() and not get_completed():
		for condition in conditions:
			condition.update()
			if not condition.get_completed():
				return
		completed = true
	super()
