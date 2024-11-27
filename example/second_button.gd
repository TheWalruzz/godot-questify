extends Button


@export var data_manager: DataManager
@export var value: String


func _ready() -> void:
	visible = false
	pressed.connect(func():
		data_manager.set_value("second_button_pressed", value)
	)
	data_manager.data_changed.connect(func(key: String, _value: Variant):
		if key == "first_button_pressed":
			visible = true
		if key == "second_button_pressed":
			visible = false
	)
	data_manager.reset_requested.connect(
		func():
			visible = false
	)
