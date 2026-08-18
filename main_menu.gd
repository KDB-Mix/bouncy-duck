extends Node2D
var LEVEL = load("res://level.tscn")
var skin_select = load("res://Select skin.tscn")
var settings_window = load("res://Settings.tscn")
@onready var score: Label = $CanvasLayer/MarginContainer/VBoxContainer/Score
@onready var flappy_bird: Sprite2D = $FlappyBird
@onready var directional_light_2d: DirectionalLight2D = $BG/Sprite2D/DirectionalLight2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score.text = str("HIGH SCORE: ", int(SaveManager.saveData[SaveManager.score_key]))
	#flappy_bird.texture.region.position.x = 32*SaveManager.saveData[SaveManager.skin_key]
	flappy_bird.frame = SaveManager.saveData[SaveManager.skin_key]
	directional_light_2d.enabled = SaveManager.saveData[SaveManager.light_key]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_button_down() -> void:
	SoundHandler.click.play(.05)
	get_tree().change_scene_to_packed(LEVEL)

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_GO_BACK_REQUEST:
		get_tree().quit()


func _on_skins_button_down() -> void:
	SoundHandler.click.play(.05)
	get_tree().change_scene_to_packed(skin_select)


func _on_settings_button_down() -> void:
	SoundHandler.click.play(.05)
	get_tree().change_scene_to_packed(settings_window)
