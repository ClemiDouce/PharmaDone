extends Button

const okmark = preload("res://okmark.png")
const notokmark = preload("res://xmark.png")

onready var texture = $Texture

func _on_Test1_toggled(button_pressed: bool) -> void:
	set_toggled_state(button_pressed)

func set_toggled_state(state: bool) -> void:
	pressed = state
	if state:
		texture.texture = okmark
	else:
		texture.texture = notokmark
