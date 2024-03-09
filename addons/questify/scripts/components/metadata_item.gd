@tool
class_name MetadataItem extends VBoxContainer


@export var key_value: LineEdit
@export var metadata_input: VariantInput
@export var remove_button: Button


var _meta_editor: MetadataEditor
var _current_key: String
var _current_value: Variant
var _debouncer: Debouncer


func _ready() -> void:
	remove_button.icon = get_theme_icon("Remove", "EditorIcons")
	_debouncer = Debouncer.new(Engine.get_meta("QuestifyPlugin").get_tree())
	
	
func set_key_value(key: String, value: Variant) -> void:
	_current_key = key
	key_value.text = key
	_current_value = value
	metadata_input.set_value(value)
	
	
func get_key() -> String:
	return _current_key
	
	
func get_value() -> Variant:
	return _current_value
	
	
func set_editor(meta_editor: MetadataEditor) -> void:
	_meta_editor = meta_editor


func _on_remove_button_pressed() -> void:
	_meta_editor.erase_value(self)
	queue_free()


func _on_metadata_input_value_changed(new_value: Variant) -> void:
	_current_value = new_value
	if not _current_key.is_empty():
		_meta_editor.set_value(self)


func _on_key_value_text_changed(new_text: String) -> void:
	_debouncer.debounce(func():
		if not _current_key.is_empty():
			_meta_editor.clear_value(self)
		_current_key = new_text
		if _current_value != null:
			_meta_editor.set_value(self)
	)
