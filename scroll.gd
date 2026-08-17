class_name BG
extends Sprite2D

@export var speed: float = 20
@onready var level: Level = $"../.."
@onready var bg: Node2D
var spawned_clone = false

var multiplier = 0.0
var initial_pos: float
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bg = get_parent()
	initial_pos = position.x


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x+=delta*speed*multiplier
	if !spawned_clone && position.x >= 0:
		var background: BG = duplicate()
		background.position.x = position.x-540
		background.position.y = 0
		bg.add_child(background)
		spawned_clone = true
		
		

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	call_deferred("queue_free")

func stop():
	multiplier = 0

func resume():
	multiplier = 1
