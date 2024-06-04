class_name QuestNode extends Resource


@export var id: String
@export var optional: bool = false
@export var graph_editor_position: Vector2
@export var graph_editor_size: Vector2


var completed: bool = false
var previous: Array[QuestNode]:
	get:
		return _graph.get_previous_nodes(self)
var next: Array[QuestNode]:
	get:
		return _graph.get_next_nodes(self)


var _graph: QuestResource


func get_completed() -> bool:
	return completed
	
	
func get_active() -> bool:
	return false
	
	
func all_previous_nodes_completed() -> bool:
	for node in previous:
		if not node.get_completed() and not node.optional:
			return false
	return true
	
	
func any_previous_nodes_completed() -> bool:
	for node in previous:
		if node.get_completed() or node.optional:
			return true
	return false
	
	
func any_children_active() -> bool:
	for node in next:
		if node.get_active():
			return true
	return false
	
	
func update() -> void:
	if get_completed():
		for node in next:
			node.update()
			
			
func set_graph(quest_resource: QuestResource) -> void:
	_graph = quest_resource
	
	
func serialize() -> Dictionary:
	return {
		id = id,
		completed = get_completed()
	}
	
	
func deserialize(data: Dictionary) -> void:
	id = data.id
	completed = data.completed
