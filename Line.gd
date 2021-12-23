extends HBoxContainer

onready var task := $Panel/Label
onready var param := $Test1
onready var test := $Test2
	
func set_title(task_title: String):
	task.text = task_title

func start_with_setting(settings: Dictionary) -> void:
	self.param.set_toggled_state(settings["param"])
	self.test.set_toggled_state(settings["test"])
	self.task.text = settings["label"]

func node_to_json():
	return {
		"param": param.pressed,
		"test": test.pressed,
		"label": task.text
	}
