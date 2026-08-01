class_name Ground
extends Node2D
const GROUNDS = preload("res://grounds.tscn")
@onready var level: Level = $"../.."
var grounds_container: Node2D
var spawned_clone = false

var multiplier = 1.0
var initial_pos: float
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	grounds_container = get_parent()
	initial_pos = position.x


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x+=delta*50*multiplier
	if !spawned_clone && position.x >= 0 && initial_pos < 0:
		var ground: Ground = GROUNDS.instantiate()
		ground.position.x = position.x-280
		ground.position.y = 0
		grounds_container.add_child(ground)
		spawned_clone = true
		
		

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	call_deferred("queue_free")

func stop():
	multiplier = 0

func resume():
	multiplier = 1
