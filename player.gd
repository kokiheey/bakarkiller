extends CharacterBody3D
@onready var camera = $cameracomponent
var bakar = preload("res://bakar.tscn")
var rot_x = 0
var rot_y = 0
var speed = 20
const move_speed = 5
@export var sens = 0.005
# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func physics_process(delta):
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (Vector3(input_dir.x, 0, input_dir.y) * camera.transform.basis).normalized() #z == foward
	if direction:
		velocity.x = direction.x * move_speed
		velocity.y = direction.y * move_speed
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)
		velocity.z = move_toward(velocity.z, 0, move_speed)
	move_and_slide()
	
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rot_x += -event.relative.x * sens
		rot_y += -event.relative.y * sens
		rot_y = clamp(rot_y, -1.5, 1.5)
		camera.transform.basis = Basis()
		camera.rotate_x(rot_y)
		camera.rotate_y(rot_x)
	if event is InputEventMouseButton:
		if event.is_action_pressed("click"):
			var ciga = bakar.instantiate()
			ciga.scale = Vector3(0.01, 0.01, 0.01)
			ciga.transform.basis = camera.transform.basis
			ciga.linear_velocity = -camera.transform.basis.z * speed
			add_child(ciga)
