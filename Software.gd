extends Control

const BaseScreen = preload("res://BaseScreen.tscn")

onready var menu_screen := $MenuScreen
onready var poste_screen := $PosteScreen
onready var credit := $Credit

func _ready():
	Global.get_config_data()
	
func set_base(state: bool):
	menu_screen.visible = !state
	poste_screen.visible = state
	credit.visible = !state

func _on_MenuScreen_launch(pharma_name, dico) -> void:
	set_base(true)
	poste_screen.init(pharma_name, dico)

func _on_MenuScreen_launch_loaded(dico) -> void:
	set_base(true)
	poste_screen.start_with_settings(dico)
	
func _on_PosteScreen_backed() -> void:
	menu_screen.reset()
	set_base(false)
