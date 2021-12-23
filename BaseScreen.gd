extends Control

onready var pharmacie_title := $ScrollContainer/Screen/Header/PharmacieTitle
onready var postes_node := $ScrollContainer/Screen/Postes

signal backed

const Poste = preload("res://Poste.tscn")

var data_dict : Dictionary

func _ready() -> void:
	self.data_dict = Global.get_config_data()
	
func reset() -> void:
	for post in postes_node.get_children():
		post.queue_free()

func init(pharma_name: String, post_dico) -> void:
	reset()
	pharmacie_title.text = "Pharmacie " + pharma_name
	for post_type in post_dico.keys():
		for i in range(post_dico[post_type]):
			var post_inst = Poste.instance()
			postes_node.add_child(post_inst)
			post_inst.create(post_type, data_dict[post_type], i+1)
			
func start_with_settings(settings: Dictionary) -> void:
	reset()
	pharmacie_title.text = settings["name"]
	for post in settings["postes"]:
		var post_inst = Poste.instance()
		postes_node.add_child(post_inst)
		post_inst.start_with_settings(post)

func node_to_json():
	var dict = {"name": pharmacie_title.text, "postes": []}
	for post in postes_node.get_children():
		dict["postes"].append(post.node_to_json())
	return dict

func _on_Button_pressed() -> void:
	Global.pharma_to_json(pharmacie_title.text.to_lower(), node_to_json())


func _on_ExportButton_pressed() -> void:
	pass # Replace with function body.


func _on_BackButton_pressed() -> void:
	emit_signal("backed")
