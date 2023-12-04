extends CharacterBody3D
@onready var camera = $cameracomponent
var bakar = preload("res://bakar.tscn")
var rot_x = 0
var rot_y = 0
var speed = 5
const move_speed = 5
@export var sens = 0.005
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	var input_dir = Input.get_vector("left", "right", "up", "down").normalized()
	velocity = input_dir.x * transform.basis.x * move_speed +  input_dir.y * transform.basis.z * move_speed
	velocity.y = 0
	move_and_slide()
	
func _input(event):
	if event is InputEventMouseMotion:
		camera.rotate_x(-event.relative.y * sens)
		rotate_y(-event.relative.x * sens)
		camera.rotation.x = clamp(camera.rotation.x, -PI/2, PI/2)
		
	if event is InputEventMouseButton:
		if event.is_action_pressed("click"):
			var ciga = bakar.instantiate()
			ciga.scale = Vector3(0.01, 0.01, 0.01)
			ciga.transform.basis = transform.basis
			ciga.linear_velocity = -transform.basis.z * speed
			add_child(ciga)
