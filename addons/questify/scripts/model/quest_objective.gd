class_name QuestObjective extends QuestNode


@export var description: String


var _has_notified: bool = false


var conditions: Array[QuestNode]:
	get:
		return _graph.get_previous_nodes(self, QuestEdge.EdgeType.CONDITIONAL)


var is_exclusive: bool:
	get:
		return _graph.get_next_nodes(self).any(
			func(node: QuestNode):
				return node is QuestExclusiveBranchConnector or node is QuestAnyPrevious
		)


func serialize() -> Dictionary:
	var data := super()
	data.has_notified = _has_notified
	return data


func deserialize(data: Dictionary) -> void:
	super(data)
	if data.has("has_notified"):
		_has_notified = data.has_notified


func get_active() -> bool:
	if get_completed():
		return false
	return all_previous_nodes_completed() and not any_children_active()


func activate_objective() -> void:
	if get_active() and _has_notified == false:
		Questify.quest_objective_added.emit(_graph, self)
		_has_notified = true


func complete_objective() -> void:
	Questify.quest_objective_completed.emit(_graph, self)


func update() -> void:
	if get_active():
		activate_objective()
		for condition in conditions:
			condition.update()
			if not condition.get_completed():
				return
		completed = true
		complete_objective()
	super()
