@tool
extends HBoxContainer


signal value_changed(value: Vector3)


var _current_value: Vector3 = Vector3.ZERO


@export var x_value: SpinBox
@export var y_value: SpinBox
@export var z_value: SpinBox


func _ready() -> void:
	x_value.value_changed.connect(func(new_value: float):
		_current_value.x = new_value
		value_changed.emit(_current_value)	
	)
	y_value.value_changed.connect(func(new_value: float):
		_current_value.y = new_value
		value_changed.emit(_current_value)	
	)
	y_value.value_changed.connect(func(new_value: float):
		_current_value.z = new_value
		value_changed.emit(_current_value)	
	)


func set_value(value: Vector3) -> void:
	x_value.value = value.x
	y_value.value = value.y
	z_value.value = value.z
