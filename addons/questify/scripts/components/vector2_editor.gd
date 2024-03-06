@tool
extends HBoxContainer


signal value_changed(value: Vector2)


var _current_value: Vector2 = Vector2.ZERO


@export var x_value: SpinBox
@export var y_value: SpinBox


func _ready() -> void:
	x_value.value_changed.connect(func(new_value: float):
		_current_value.x = new_value
		value_changed.emit(_current_value)	
	)
	y_value.value_changed.connect(func(new_value: float):
		_current_value.y = new_value
		value_changed.emit(_current_value)	
	)


func set_value(value: Vector2) -> void:
	x_value.value = value.x
	y_value.value = value.y
