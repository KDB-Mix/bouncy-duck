@icon("res://pillar.png")
class_name Pillar
extends Area2D
@onready var level: Level = $"../.."
@onready var top: Sprite2D = $top
@onready var bottom: Sprite2D = $bottom

var multiplier = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#top.position.y = randf_range(-120, -100)
	#bottom.position.y = randf_range(90, 110)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position.x += delta*100*multiplier


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	call_deferred("queue_free")


func _on_body_entered(body: Node2D) -> void:
	if body is Bird:
		var bird: Bird = body
		bird.death()
		multiplier = 0
		
func stop():
	multiplier = 0

func resume():
	multiplier = 1


func _on_points_body_entered(body: Node2D) -> void:
	if body is Bird:
		level.points += 1
