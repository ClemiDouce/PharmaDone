extends HBoxContainer

onready var label = $Title
onready var input = $LineEdit

var value : int = 0 setget set_value
export (int) var min_value = 0
export (int) var max_value = 100

export (String) var title = "Poste"

func _ready() -> void:
	self.label.text = self.title
	self.value = 0

func _on_LessButton_pressed() -> void:
	self.value = max(value - 1, min_value)


func _on_MoreButton_pressed() -> void:
	self.value = min(value + 1, max_value)

func set_value(new_value: int) -> void:
	value = new_value
	input.text = str(value)
