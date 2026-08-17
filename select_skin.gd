extends Node2D
var main_menu: PackedScene = load("res://main_menu.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(SaveManager.saveData)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_home_button_down() -> void:
	get_tree().change_scene_to_packed(main_menu)


func _on_bird_1_button_down() -> void:
	SaveManager.saveData[SaveManager.skin_key] = 0
	SaveManager.save_file()
	_on_home_button_down()


func _on_bird_2_button_down() -> void:
	SaveManager.saveData[SaveManager.skin_key] = 1
	SaveManager.save_file()
	_on_home_button_down()

func _on_bird_3_button_down() -> void:
	SaveManager.saveData[SaveManager.skin_key] = 2
	SaveManager.save_file()
	_on_home_button_down()


func _on_bird_4_button_down() -> void:
	SaveManager.saveData[SaveManager.skin_key] = 3
	SaveManager.save_file()
	_on_home_button_down()
