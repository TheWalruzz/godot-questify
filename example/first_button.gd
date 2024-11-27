extends Button


@export var data_manager: DataManager


func _ready() -> void:
	pressed.connect(func():
		data_manager.set_value("first_button_pressed", true)
	)
	
	data_manager.data_changed.connect(func(key: String, value: Variant):
		if key == "first_button_pressed":
			visible = not value
	)
	
	data_manager.reset_requested.connect(
		func():
			visible = true
	)
