@tool
class_name VariantInput extends HBoxContainer


signal value_changed(value: Variant)


@export var type_select: OptionButton
@export var inputs_container: Control


func _ready() -> void:
	type_select.set_item_icon(0, get_theme_icon("bool", "EditorIcons"))
	type_select.set_item_icon(1, get_theme_icon("String", "EditorIcons"))
	type_select.set_item_icon(2, get_theme_icon("Vector2", "EditorIcons"))
	type_select.set_item_icon(3, get_theme_icon("Vector3", "EditorIcons"))
	type_select.set_item_icon(4, get_theme_icon("int", "EditorIcons"))
	type_select.set_item_icon(5, get_theme_icon("float", "EditorIcons"))
	
	
func select_type(index: int) -> void:
	for child in inputs_container.get_children():
		child.visible = false
	inputs_container.get_child(index).visible = true
	
	
func set_value(value: Variant) -> void:
	var index: int
	if value is bool:
		index = 0
	if value is String:
		index = 1
	if value is Vector2:
		index = 2
	if value is Vector3:
		index = 3
	if value is int:
		index = 4
	if value is float:
		index = 5
	type_select.select(index)
	select_type(index)
	var input = inputs_container.get_child(index)
	match index:
		0: #bool
			input.button_pressed = value
		1: #String
			input.text = value
		2: #Vector2
			input.set_value(value)
		3: #Vector3
			input.set_value(value)
		4, 5: #int, float
			input.value = value


func _on_type_selected(index: int) -> void:
	select_type(index)
	
	
func _on_value_changed(value: Variant) -> void:
	value_changed.emit(value)
