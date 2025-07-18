extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D
const speed = 200.0
const jump_power = -350.0

func _ready():
	pass

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_power

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()

	handle_movement_animation(direction)
	
func handle_movement_animation(dir):
	var weapon_equip = Global.playerWeaponEquip
	if !weapon_equip:
		if is_on_floor():
			if !velocity:
				animated_sprite.play("idle")
			if velocity:
				animated_sprite.play("run")
				toggle_flip_sprite(dir)
		elif !is_on_floor():
			animated_sprite.play("fall")
	if weapon_equip:
		if is_on_floor():
			if !velocity:
				animated_sprite.play("weapon_idle")
			if velocity:
				animated_sprite.play("weapon_run")
				toggle_flip_sprite(dir)
		elif !is_on_floor():
			animated_sprite.play("weapon_fall")
			
func toggle_flip_sprite(dir):
	if dir > 0:
		animated_sprite.flip_h = false
	elif dir < 0:
		animated_sprite.flip_h = true
