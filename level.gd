class_name Level
extends Node2D

var pillar_scene: PackedScene = preload("res://pillar.tscn")

@onready var pillar_spawn: Marker2D = %"pillar spawn"
@onready var spawn_timer: Timer = $spawnTimer
@onready var score: Label = $ui/MarginContainer/GridContainer/CenterContainer/Score
@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D
@onready var celebration_text: RichTextLabel = $"ui/MarginContainer/GridContainer/CenterContainer2/Celebration Text"
@onready var pause_menu: NinePatchRect = $"ui/Pause menu"
@onready var pause: Button = $ui/Pause
@onready var dark_bg: ColorRect = $"ui/Dark bg"
@onready var player: Bird = %Player
@onready var grounds_container: Node2D = $groundsContainer
@onready var bg: Node2D = $BG
var MAIN_MENU = load("res://main_menu.tscn")
@onready var control: Control = $Control
@onready var directional_light_2d: DirectionalLight2D = $BG/Sprite2D/DirectionalLight2D

const GROUNDS = preload("res://grounds.tscn")

var spawn_pillars = false
var spawn_grounds = false
var points = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cpu_particles_2d.position.y = -(control.get_viewport_rect().size.y-960)/6
	#spawn_timer.start()
	celebration_text.visible = false
	for child in grounds_container.get_children():
			if child is Ground:
				var ground: Ground = child
				ground.stop()
	directional_light_2d.enabled = SaveManager.saveData[SaveManager.light_key]
	GlobalValues.destroyed_pillars.clear()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	score.text = str(points)
	pause.visible = !pause_menu.visible
	dark_bg.visible = pause_menu.visible


func _on_spawn_timer_timeout() -> void:
	if spawn_pillars:
		if GlobalValues.destroyed_pillars.is_empty():
			var pillar: Area2D = pillar_scene.instantiate()
			pillar_spawn.add_child(pillar)
			pillar.global_position.x = pillar_spawn.global_position.x
			pillar.global_position.y = randf_range(60, 260)
		else:
			var pillar: Area2D = GlobalValues.destroyed_pillars.pop_at(0)
			print("Spawned: ", GlobalValues.destroyed_pillars)
			pillar.global_position.x = pillar_spawn.global_position.x
			pillar.global_position.y = randf_range(60, 260)
		#print("spawned")
	spawn_timer.start()


func _on_pause_button_down() -> void:
	if !pause_menu.visible:
		SoundHandler.click.play(.05)
		pause_menu.visible = true
		get_tree().paused = true
		if !player.paused && player.started:
			player.Pause()

func _on_resume_button_down() -> void:
	SoundHandler.click.play(.05)
	pause_menu.visible = false
	get_tree().paused = false

func pause_pressed():
	if pause_menu.visible:
		_on_resume_button_down()
	else:
		_on_pause_button_down()


func _on_restart_button_down() -> void:
	SoundHandler.click.play(.05)
	get_tree().paused = false
	get_tree().reload_current_scene()
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		pause_pressed()

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_GO_BACK_REQUEST:
		pause_pressed()


func _on_home_button_down() -> void:
	SoundHandler.click.play(.05)
	get_tree().paused = false
	get_tree().change_scene_to_packed(MAIN_MENU)
	
