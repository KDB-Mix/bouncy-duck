@icon("res://flappy bird.png")
class_name Bird
extends CharacterBody2D

var started: bool = false
@export var jump_velocity: float = 200
var gravity: float
@onready var pillar_spawn: Marker2D = %"pillar spawn"
@onready var level: Level = $".."
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var pause: Button = $"../ui/Pause"
@onready var grounds_container: Node2D = $"../groundsContainer"
@onready var bg: Node2D = $"../BG"

var paused: bool
var lastVelocity: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite_2d.texture.region.position.x = 32*SaveManager.saveData[SaveManager.skin_key]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if started && !paused:
		gravity = get_gravity().y
		velocity.y += gravity*delta
		sprite_2d.rotation_degrees = clamp(-velocity.y/3, -50, 50)
	
	move_and_slide()
	  
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		Jump()

func death():
	for child in pillar_spawn.get_children():
		if child is Pillar:
			var pillar: Pillar = child
			pillar.stop()
	for child in grounds_container.get_children():
		if child is Ground:
			var ground: Ground = child
			ground.stop()
	for child in bg.get_children():
		if child is BG:
			var background: BG = child
			background.stop()
	started = false
	gravity = 0
	velocity = Vector2.ZERO
	level.spawn_pillars = false
	level.spawn_timer.stop()
	paused = false
	if SaveManager.save_score(level.points): 
		level.cpu_particles_2d.position.y = -(level.control.get_viewport_rect().size.y-960)/6
		SoundHandler.celebrate.play()
		level.cpu_particles_2d.emitting = true
		level.celebration_text.visible = true
	else:
		SoundHandler.lost.play(.3)

func _on_borders_body_entered(body: Node2D) -> void:
	death()
	

func Jump():
	if paused:
		Pause()
		return
	if !started:
		for child in grounds_container.get_children():
			if child is Ground:
				var ground: Ground = child
				ground.resume()
		for child in bg.get_children():
			if child is BG:
				var background: BG = child
				background.resume()
		level.celebration_text.visible = false
		level.points = 0
		level.spawn_pillars = true
		level.spawn_timer.start()
		for child in pillar_spawn.get_children():
			child.call_deferred("queue_free")
		global_position.y = 160
		started = true
	SoundHandler.jump.play(.06)
	velocity.y = -jump_velocity


func _on_touch_button_down() -> void:
	Jump()
	
func Pause():
	if !paused:
		#stop pillars and ground
		for child in pillar_spawn.get_children():
			if child is Pillar:
				var pillar: Pillar = child
				pillar.stop()
		for child in grounds_container.get_children():
			if child is Ground:
				var ground: Ground = child
				ground.stop()
		#stop
		gravity = 0
		lastVelocity = velocity
		velocity = Vector2.ZERO
		#dont spawn anything
		level.spawn_pillars = false
		level.spawn_timer.paused = true
		
		paused = true
	else:
		#resume pillars and ground
		for child in pillar_spawn.get_children():
			if child is Pillar:
				var pillar: Pillar = child
				pillar.resume()
		for child in grounds_container.get_children():
			if child is Ground:
				var ground: Ground = child
				ground.resume()
		#keep moving
		velocity = lastVelocity
		#keep spawning
		level.spawn_pillars = true
		level.spawn_timer.paused = false
		
		paused = false
	
