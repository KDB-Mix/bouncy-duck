extends Node2D
var main_menu: PackedScene = load("res://main_menu.tscn")
@onready var volume: HSlider = $CanvasLayer/MarginContainer/VBoxContainer/HBoxContainer/Volume
@onready var lighting: CheckButton = $CanvasLayer/MarginContainer/VBoxContainer/HBoxContainer2/Lighting
@onready var texture_rect: TextureRect = $CanvasLayer/MarginContainer/VBoxContainer/HBoxContainer/TextureRect
@onready var directional_light_2d: DirectionalLight2D = $BG/Sprite2D/DirectionalLight2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	volume.value = SaveManager.saveData[SaveManager.volume_key]
	lighting.button_pressed = SaveManager.saveData[SaveManager.light_key]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if volume.value == 0:
		texture_rect.texture.region.position.x = 96
	else:
		texture_rect.texture.region.position.x = 0
	directional_light_2d.enabled = lighting.button_pressed


func _on_home_button_down() -> void:
	SoundHandler.click.play(.05)
	SaveManager.saveData[SaveManager.volume_key] = volume.value
	SaveManager.saveData[SaveManager.light_key] = lighting.button_pressed
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("SFX"), volume.value/100)
	SaveManager.save_file()
	get_tree().change_scene_to_packed(main_menu)


func _on_volume_drag_ended(value_changed: bool) -> void:
	if value_changed:
		pass
