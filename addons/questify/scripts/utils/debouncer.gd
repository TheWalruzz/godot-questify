@tool
class_name Debouncer extends RefCounted


const DEFAULT_DEBOUNCE_TIME = 0.25 # s


var _tree: SceneTree
var _debounce_time: float
var _timer: SceneTreeTimer


func _init(tree: SceneTree, time := DEFAULT_DEBOUNCE_TIME) -> void:
	_tree = tree
	_debounce_time = time
	
	
func debounce(callable: Callable) -> void:
	if _timer != null:
		_disconnect_timer()
		_timer = null
	_timer = _tree.create_timer(_debounce_time)
	_timer.timeout.connect(callable, CONNECT_ONE_SHOT)


func _disconnect_timer() -> void:
	for connection in _timer.timeout.get_connections():
		_timer.timeout.disconnect(connection.callable)
