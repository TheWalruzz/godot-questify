extends Node


signal condition_query_requested(type: String, key: String, value: Variant, requester: QuestCondition)
signal quest_started(quest: QuestResource)
signal quest_objective_added(quest: QuestResource, objective: QuestObjective)
signal quest_objective_completed(quest: QuestResource, objective: QuestObjective)
signal quest_completed(quest: QuestResource)


var _quests: Array[QuestResource] = []


var update_interval: float:
	get: return ProjectSettings.get_setting("questify/general/update_interval") as float


var _quest_update_timer: Timer


func _ready() -> void:
	_add_timer()
	_quest_update_timer.timeout.connect(
		func():
			for quest in _quests:
				quest.update()
	)
	
	
func start_quest(quest_resource: QuestResource) -> void:
	_quests.append(quest_resource)
	quest_resource.start()
	

func clear() -> void:
	_quests.clear()
	
	
func get_quests() -> Array[QuestResource]:
	return _quests
	
	
func set_quests(quests: Array[QuestResource]) -> void:
	clear()
	_quests.assign(quests)
	
	
func toggle_quest_check(value: bool) -> void:
	_quest_update_timer.paused = not value
	
	
func _add_timer() -> void:
	_quest_update_timer = Timer.new()
	_quest_update_timer.autostart = true
	_quest_update_timer.wait_time = update_interval
	add_child(_quest_update_timer)
