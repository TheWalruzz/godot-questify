@tool
extends HBoxContainer


signal value_changed(value: String)


@export var line_edit: LineEdit
@export var file_dialog: FileDialog
@export var open_button: Button


func _ready() -> void:
	line_edit.text_changed.connect(func(new_text: String): value_changed.emit(new_text))
	open_button.icon = get_theme_icon("Folder", "EditorIcons")


func set_value(text: String) -> void:
	line_edit.text = text


func set_value_notify(text: String) -> void:
	set_value(text)
	value_changed.emit(text)


func _on_file_dialog_file_selected(path: String) -> void:
	set_value_notify(path)


func _on_open_button_pressed() -> void:
	file_dialog.show()
