extends Control

signal launch(pharma_name, dico)
signal launch_loaded(dico)

var file_choice : String = ""
var file_path_list : Array = []

onready var pharmacie_name := $CenterContainer/VBoxContainer/NomPharmaLine/LineEdit
onready var presence_serveur := $CenterContainer/VBoxContainer/PosteServeur/SpinBox
onready var nbr_comptoir := $CenterContainer/VBoxContainer/NbrComptoir
onready var nbr_deballage := $CenterContainer/VBoxContainer/NbrDeballage
onready var nbr_bureau := $CenterContainer/VBoxContainer/NbrBureau

onready var option_button := $CenterContainer/VBoxContainer/HBoxContainer/OptionButton

func _ready() -> void:
	reset()
		
func reset() -> void:
	pharmacie_name.text = ""
	presence_serveur.set_toggled_state(true)
	nbr_comptoir.value = 0
	nbr_deballage.value = 0
	nbr_bureau.value = 0
	load_file()
	print(file_path_list)
	file_choice = file_path_list[0] if file_path_list.size() > 0 else ""
	
func load_file() -> void:
	file_path_list = []
	option_button.clear()
	var file_list = Global.get_all_pharma_files()
	for key in file_list.keys():
		option_button.add_item(file_list[key]["label"])
		file_path_list.append(file_list[key]["path"])

func _on_Start_pressed() -> void:
	var data_dict = {
		"serveur" : 1 if presence_serveur.pressed else 0,
		"comptoir": int(nbr_comptoir.value),
		"deballage": int(nbr_deballage.value),
		"bureau": int(nbr_bureau.value)
	}
	emit_signal("launch", pharmacie_name.text, data_dict)

func _on_LoadFile_pressed() -> void:
	if file_choice == "":
		return
	var file = File.new()
	file.open(file_choice, File.READ)
	var pharma_file = JSON.parse(file.get_as_text()).result
	file.close()
	emit_signal("launch_loaded", pharma_file)	

func _on_OptionButton_item_selected(index: int) -> void:
	print(index)
	file_choice = file_path_list[index]


func _on_DeleteFile_pressed() -> void:
	if file_choice == "":
		return
	var dir = Directory.new()
	if dir.file_exists(file_choice):
		dir.remove(file_choice)
		load_file()
		file_choice = file_path_list[0] if file_path_list.size() > 0 else ""
