@tool
extends LineEdit


func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	return data.type == "files" and data.files.size() == 1 and (
		data.files[0].ends_with(".tres") or data.files[0].ends_with(".res")
	)


func _drop_data(_at_position: Vector2, data: Variant) -> void:
	text = data.files[0]
	text_changed.emit(text)
