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
	get_tree().change_scene_to_packed(LEVEL)
