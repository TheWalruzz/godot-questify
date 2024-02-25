class_name QuestObjective extends QuestNode


@export var description: String


var conditions: Array[QuestNode]:
	get:
		return _graph.get_previous_nodes(self, QuestEdge.EdgeType.CONDITIONAL)
		
		
var is_exclusive: bool:
	get:
		return _graph.get_next_nodes(self).any(
			func(node: QuestNode): 
				return node is QuestExclusiveBranchConnector or node is QuestAnyPrevious
		)


func get_active() -> bool:
	if get_completed():
		return false
	return all_previous_nodes_completed() and not any_children_active()
	
	
func update() -> void:
	if get_active():
		for condition in conditions:
			condition.update()
			if not condition.get_completed():
				return
		completed = true
		_graph.complete_objective(self)
	super()
