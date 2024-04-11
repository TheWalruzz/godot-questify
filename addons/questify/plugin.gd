@tool
extends EditorPlugin


const QuestEditorViewScene = preload("./scenes/quest_editor_view.tscn")


var quest_editor_view: QuestEditorView


func _enter_tree() -> void:
	add_autoload_singleton("Questify", "quest_manager.gd")
	
	QuestifySettings.init_settings()
	
	Engine.set_meta("QuestifyPlugin", self)
	
	quest_editor_view = QuestEditorViewScene.instantiate() as QuestEditorView
	EditorInterface.get_editor_main_screen().add_child(quest_editor_view)
	_make_visible(false)


func _exit_tree() -> void:
	Engine.remove_meta("QuestifyPlugin")
	
	remove_autoload_singleton("Questify")
	
	if is_instance_valid(quest_editor_view):
		quest_editor_view.queue_free()
		
		
func get_version() -> String:
	var config: ConfigFile = ConfigFile.new()
	config.load(get_plugin_path() + "/plugin.cfg")
	return config.get_value("plugin", "version")
	
	
func get_plugin_path() -> String:
	return get_script().resource_path.get_base_dir()


func _has_main_screen() -> bool:
	return true


func _make_visible(next_visible: bool) -> void:
	if is_instance_valid(quest_editor_view):
		quest_editor_view.visible = next_visible


func _get_plugin_name() -> String:
	return "Questify"


func _get_plugin_icon() -> Texture2D:
	return preload("./assets/icon.svg")
	
	
func _apply_changes() -> void:
	quest_editor_view.apply_changes()
	
	
func _handles(object: Object) -> bool:
	return object is QuestResource
	
	
func _edit(object: Object) -> void:
	if is_instance_valid(quest_editor_view) and is_instance_valid(object):
		quest_editor_view.load_resource(object as QuestResource)
