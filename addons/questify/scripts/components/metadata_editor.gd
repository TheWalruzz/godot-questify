@tool
class_name MetadataEditor extends VBoxContainer


const MetadataItemScene = preload("../../scenes/metadata_item.tscn")


@export var container: Node
@export var items_container: VBoxContainer


func update() -> void:
	for key in container.get_meta_list():
		_add_item(key, container.get_meta(key))


func set_value(key: String, value: Variant) -> void:
	container.set_meta(key, value)
	
	
func clear_value(key: String) -> void:
	container.remove_meta(key)
	
	
func _add_item(key := "", value: Variant = false) -> MetadataItem:
	var instance := MetadataItemScene.instantiate() as MetadataItem
	instance.set_editor(self)
	items_container.add_child(instance)
	instance.set_key_value(key, value)
	return instance


func _on_add_metadata_button_pressed() -> void:
	_add_item()
