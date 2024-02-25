extends Button


@export var data_manager: DataManager


func _ready() -> void:
	pressed.connect(func():
		data_manager.set_value("first_button_pressed", true)
		queue_free(),
		CONNECT_ONE_SHOT
	)
