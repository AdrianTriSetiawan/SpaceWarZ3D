extends KinematicBody

const MAX_SPEED = 30
const ACCELERATION = 2
var inputVector = Vector2()
var velo = Vector3()
var cooldown = 0
const COOLDOWN = 0.1

onready var joystick = get_parent().get_node("HBoxContainer/Sprite/TouchScreenButton")
onready var guns = [$Gun0, $Gun1]
onready var main = get_tree().current_scene
var Bullet = load("res://Bullet.tscn")

func _physics_process(delta):
	if joystick:
		inputVector.x = clamp(joystick.get_value().x, -1, 1)
		inputVector.y = clamp(joystick.get_value().y, -1, 1)
	else:
		inputVector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		inputVector.y = Input.get_action_strength("ui_up") - Input.get_action_strength("ui_down")
		inputVector = inputVector.normalized()

	# Gerakan horizontal
	velo.x = move_toward(velo.x, inputVector.x * MAX_SPEED, ACCELERATION)
	# Gerakan naik dan turun
	velo.y = move_toward(velo.y, -inputVector.y * MAX_SPEED, ACCELERATION)

	rotation_degrees.z = velo.x * -2
	rotation_degrees.x = velo.y / 2
	rotation_degrees.y = -velo.x / 2

	move_and_slide(Vector3(velo.x, 0, velo.y))

	transform.origin.x = clamp(transform.origin.x, -15, 15)
	transform.origin.y = clamp(transform.origin.y, -10, 10)

	# Shooting
	if Input.is_action_pressed("ui_accept") and cooldown <= 0:
		cooldown = COOLDOWN
		for i in guns:
			var bullet = Bullet.instance()
			main.add_child(bullet)
			bullet.transform = i.global_transform
			bullet.velo = bullet.transform.basis.z * -600

	# Cooldown
	cooldown = max(0, cooldown - delta)
