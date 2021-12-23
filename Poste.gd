extends VBoxContainer

const Line := preload("res://Line.tscn")

onready var line_node := $LineContainer
onready var title := $Header/Panel3/Label

func create(poste_title: String, line_list: PoolStringArray, number: int) -> void:
	title.text = "Poste " + poste_title.capitalize() + " #" + str(number)
	for line in line_list:
		if line == "":
			continue
		var instance = Line.instance()
		line_node.add_child(instance)
		instance.set_title(line.capitalize())

func start_with_settings(settings: Dictionary) -> void:
	self.title.text = settings["name"]
	for line in settings["lines"]:
		var instance = Line.instance()
		line_node.add_child(instance)
		instance.start_with_setting(line)

func node_to_json():
	var dict = {"name": self.title.text, "lines": []}
	for line in line_node.get_children():
		dict["lines"].append(line.node_to_json())
	return dict
