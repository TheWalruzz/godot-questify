@tool
class_name QuestResource extends Resource


@export var nodes: Array[QuestNode] = []
@export var edges: Array[QuestEdge] = []


var name: String:
	get: return start_node.name
	
var description: String:
	get: return start_node.description
	
var start_node: QuestStart
		
var started: bool:
	get: return start_node.active
		
var completed: bool = false
var is_instance := false


func instantiate() -> QuestResource:
	if is_instance:
		return self
	var instance := duplicate(true) as QuestResource
	
	var duplicated_nodes: Array[QuestNode] = []
	var duplicated_edges: Array[QuestEdge] = []
	
	var node_map := {}
	# Arrays cannot be duplicated in resources, so duplicate them manually
	for node in nodes:
		var new_node := node.duplicate(true)
		node_map[node] = new_node
		duplicated_nodes.append(new_node)
	for edge in edges:
		var new_edge: QuestEdge = edge.duplicate(true)
		# assign new references for edges
		if edge.from != null:
			new_edge.from = node_map[edge.from]
		if edge.to != null:
			new_edge.to = node_map[edge.to]
		duplicated_edges.append(new_edge)	
		
	instance.nodes = duplicated_nodes
	instance.edges = duplicated_edges
		
	instance.is_instance = true
	instance.set_meta("resource_path", resource_path)
	instance._initialize()
	return instance


func start() -> void:
	if not is_instance:
		printerr("Quest must be instantiated to be started. Use instantiate().")
		return
	if not completed and not started:
		start_node.active = true
		Questify.quest_started.emit(self)
		_notify_active_objectives()
		
		
func update() -> void:
	if not is_instance:
		printerr("Quest must be instantiated to be updated. Use instantiate().")
		return
	if not completed:
		start_node.update()
	
	
func get_active_objectives() -> Array[QuestObjective]:
	var objectives: Array[QuestObjective] = []
	for node in nodes:
		if node is QuestObjective and node.get_active():
			objectives.append(node)
	return objectives
	
	
func get_next_nodes(node: QuestNode, edge_type: QuestEdge.EdgeType = QuestEdge.EdgeType.NORMAL) -> Array[QuestNode]:
	var result: Array[QuestNode] = []
	result.assign(edges.filter(
		func(edge: QuestEdge):
			return edge.from == node and edge.edge_type == edge_type
	).map(
		func(edge: QuestEdge):
			return edge.to
	))
	return result
	
	
func get_previous_nodes(node: QuestNode, edge_type: QuestEdge.EdgeType = QuestEdge.EdgeType.NORMAL) -> Array[QuestNode]:
	var result: Array[QuestNode] = []
	result.assign(edges.filter(
		func(edge: QuestEdge):
			return edge.to == node and edge.edge_type == edge_type
	).map(
		func(edge: QuestEdge):
			return edge.from
	))
	return result


func get_resource_path() -> String:
	if is_instance:
		return get_meta("resource_path")
	return resource_path
	
	
func request_query(type: String, key: String, value: Variant, requester: QuestCondition) -> void:
	Questify.condition_query_requested.emit(type, key, value, requester)
	
	
func complete_objective(objective: QuestObjective) -> void:
	Questify.quest_objective_completed.emit(self, objective)
	_notify_active_objectives()
	
	
func complete_quest() -> void:
	completed = true
	Questify.quest_completed.emit(self)

	
func serialize() -> Dictionary:
	return {
		completed = completed,
		nodes = nodes.map(func(node: QuestNode): return node.serialize())
	}
	
	
func deserialize(data: Dictionary) -> void:
	if not is_instance:
		printerr("Quest must be instantiated to be deserialized. Use instantiate().")
		return
	completed = data.completed
	var node_map := {}
	for node in nodes:
		node_map[node.id] = node
	for node in data.nodes:
		if node_map.has(node.id):
			node_map[node.id].deserialize(node)
	
	
func _initialize() -> void:
	for node in nodes:
		node.set_graph(self)
		if node is QuestStart:
			start_node = node as QuestStart
		
		
func _notify_active_objectives() -> void:
	for objective in get_active_objectives():
		Questify.quest_objective_added.emit(self, objective)
