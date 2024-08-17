@tool
class_name QuestEditorView extends Control


const graph_nodes = [
	{label = "Start Node", scene = preload("../scenes/nodes/quest_start_node.tscn")},
	{label = "End Node", scene = preload("../scenes/nodes/quest_end_node.tscn")},
	{label = "Objective Node", scene = preload("../scenes/nodes/quest_objective_node.tscn")},
	{label = "Any Previous Node", scene = preload("../scenes/nodes/quest_any_previous_node.tscn")},
	{label = "Exclusive Branch Connector Node", scene = preload("../scenes/nodes/quest_exclusive_branch_connector_node.tscn")},
	{label = "Conditional Branch Node", scene = preload("res://addons/questify/scenes/nodes/quest_conditional_branch_node.tscn")},
	{label = "Condition Node", scene = preload("../scenes/nodes/quest_condition_node.tscn")},
	{label = "Any Condition Node", scene = preload("../scenes/nodes/quest_any_condition_node.tscn")},
	{label = "Not Condition Node", scene = preload("../scenes/nodes/quest_not_condition_node.tscn")},
]


var current_file_path: String = ""


@onready var quest_graph_editor: QuestGraphEditor = %QuestGraphEditor as QuestGraphEditor
@onready var new_button: Button = %NewButton as Button
@onready var open_button: Button = %OpenButton as Button
@onready var save_button: Button = %SaveButton as Button
@onready var add_node_button: Button = %AddNodeButton as Button
@onready var save_file_dialog: FileDialog = $SaveFileDialog as FileDialog
@onready var load_file_dialog: FileDialog = $LoadFileDialog as FileDialog
@onready var add_node_popup_menu: PopupMenu = $AddNodePopupMenu as PopupMenu
@onready var version_label: Label = %VersionLabel as Label


func _ready() -> void:
	new_button.icon = get_theme_icon("New", "EditorIcons")
	open_button.icon = get_theme_icon("Load", "EditorIcons")
	save_button.icon = get_theme_icon("Save", "EditorIcons")
	add_node_button.icon = get_theme_icon("Add", "EditorIcons")
	
	add_node_popup_menu.clear()
	for item in graph_nodes:
		add_node_popup_menu.add_item(item.label)
	
	version_label.text = "v%s" % Engine.get_meta("QuestifyPlugin").get_version()


func apply_changes() -> void:
	if quest_graph_editor.get_child_count() > 0:
		save_changes()
		
		
func save_file(path: String) -> void:
	var error := quest_graph_editor.save(path)
	if error == OK:
		current_file_path = path
		EditorInterface.get_resource_filesystem().scan()
		return
	# TODO: better error handling
	printerr(error)
	
	
func save_changes() -> void:
	if current_file_path.is_empty():
		if not quest_graph_editor.get_child_nodes().is_empty():
			save_file_dialog.popup()
	else:
		save_file(current_file_path)
	
	
func load_file(path: String) -> void:
	quest_graph_editor.load(path)
	current_file_path = path
	
	
func load_resource(resource: QuestResource) -> void:
	load_file(resource.resource_path)
	

func _on_add_node_index_pressed(index: int) -> void:
	quest_graph_editor.add_node(graph_nodes[index].scene.instantiate(), quest_graph_editor.get_local_mouse_position())


func _on_save_button_pressed() -> void:
	save_changes()
	

func _on_save_file_dialog_file_selected(path: String) -> void:
	save_file(path)
		
		
func _on_load_file_dialog_file_selected(path: String) -> void:
	load_file(path)


func _on_popup_request(_click_position: Vector2) -> void:
	add_node_popup_menu.popup_on_parent(Rect2(get_global_mouse_position(), Vector2.ZERO))


func _on_add_node_button_pressed() -> void:
	add_node_popup_menu.popup_on_parent(Rect2(add_node_button.global_position, Vector2.ZERO))


func _on_open_button_pressed() -> void:
	load_file_dialog.popup()


func _on_new_button_pressed() -> void:
	quest_graph_editor.clear()
	current_file_path = ""
