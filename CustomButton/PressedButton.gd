extends Button

onready var label = $Label

func _ready() -> void:
	set_toggled_state(self.pressed)

func set_toggled_state(state: bool) -> void:
	pressed = state
	if state:
		label.text = "OUI"
		self.self_modulate = Color.aquamarine
	else:
		label.text = "NON"
		self.self_modulate = Color.lightcoral		

func _on_PressedButton_toggled(button_pressed: bool) -> void:
	set_toggled_state(button_pressed)
