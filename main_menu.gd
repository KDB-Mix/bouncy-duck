extends Node2D
var LEVEL = load("res://level.tscn")
@onready var score: Label = $CanvasLayer/MarginContainer/VBoxContainer/Score


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score.text = str("HIGH SCORE: ", int(SaveManager.saveData[SaveManager.score_key]))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_button_down() -> void:
	SoundHandler.click.play()
	get_tree().change_scene_to_packed(LEVEL)

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_GO_BACK_REQUEST:
		get_tree().quit()
