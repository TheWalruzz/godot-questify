@tool
class_name MetadataEditor extends VBoxContainer


const MetadataItemScene = preload("../../scenes/metadata_item.tscn")


@export var container: Node
@export var items_container: VBoxContainer


var _current_meta: Array[MetadataItem] = []


func update() -> void:
	for key in container.get_meta_list():
		_add_item(key, container.get_meta(key))


func set_value(caller: MetadataItem) -> void:
	var key := caller.get_key()
	var already_has_key := _current_meta.any(
		func(meta_item: MetadataItem): 
			return meta_item != caller and meta_item.get_key() == key
	)
	if already_has_key:
		printerr("Metadata key '%s' already added to the node. Changes will not be saved." % key)
		return
	container.set_meta(key, caller.get_value())
	
	
func clear_value(caller: MetadataItem) -> void:
	var key := caller.get_key()
	if container.has_meta(key):
		container.remove_meta(key)
		
		
func erase_value(caller: MetadataItem) -> void:
	clear_value(caller)
	if _current_meta.has(caller):
		_current_meta.erase(caller)
	
	
func _add_item(key := "", value: Variant = false) -> MetadataItem:
	var instance := MetadataItemScene.instantiate() as MetadataItem
	instance.set_editor(self)
	items_container.add_child(instance)
	instance.set_key_value(key, value)
	_current_meta.append(instance)
	return instance


func _on_add_metadata_button_pressed() -> void:
	_add_item()
