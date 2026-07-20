class_name Level
extends Node2D

var pillar_scene: PackedScene = preload("res://pillar.tscn")

@onready var pillar_spawn: Marker2D = %"pillar spawn"
@onready var spawn_timer: Timer = $spawnTimer
@onready var score: Label = $ui/MarginContainer/GridContainer/CenterContainer/Score

var spawn_pillars = false
var points = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#spawn_timer.start()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	score.text = str(points)


func _on_spawn_timer_timeout() -> void:
	if spawn_pillars:
		var pillar: Area2D = pillar_scene.instantiate()
		pillar_spawn.add_child(pillar)
		pillar.global_position.x = global_position.x
		pillar.global_position.y = randf_range(60, 260)
		#print("spawned")
	spawn_timer.start()
