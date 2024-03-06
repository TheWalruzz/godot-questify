@tool
class_name MetadataItem extends VBoxContainer


@export var key_value: LineEdit
@export var metadata_input: MetadataInput
@export var remove_button: Button


var _meta_editor: MetadataEditor


func _ready() -> void:
	remove_button.icon = get_theme_icon("Remove", "EditorIcons")
	
	
func set_key_value(key: String, value: Variant) -> void:
	key_value.text = key
	metadata_input.set_value(value)
	
	
func set_editor(meta_editor: MetadataEditor) -> void:
	_meta_editor = meta_editor


func _on_remove_button_pressed() -> void:
	_meta_editor.clear_value(key_value.text)
	queue_free()


func _on_metadata_input_value_changed(value: Variant) -> void:
	# TODO: make it more resilient when key changes, but value doesn't
	if not key_value.text.is_empty():
		_meta_editor.set_value(key_value.text, value)
