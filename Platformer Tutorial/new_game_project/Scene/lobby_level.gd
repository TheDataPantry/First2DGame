extends Node2D

@onready var player_camera = $Player/Camera2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_camera.enabled = true
	Global.playerWeaponEquip = false
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
