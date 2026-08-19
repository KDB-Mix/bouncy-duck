class_name BG
extends Sprite2D

@export var speed: float = 20
@onready var level: Level = $"../.."
@onready var bg: Node2D
@export var spawned_clone = false
@onready var visible_on_screen_notifier_2d: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D

var multiplier = 0.0
var initial_pos: float
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bg = get_parent()
	initial_pos = position.x


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position.x+=delta*speed*multiplier
	#if !spawned_clone && position.x >= 0:
		#var background: BG = duplicate()
		#bg.add_child(background)
		#background.multiplier = multiplier
		#background.global_position.x = global_position.x-540
		#background.global_position.y = 0
		#spawned_clone = true
		


func stop():
	multiplier = 0

func resume():
	multiplier = 1


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	await visible_on_screen_notifier_2d.screen_exited
	global_position.x-=1080
