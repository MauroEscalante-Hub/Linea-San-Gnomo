class_name Camara
extends Node3D
 
@export var smooth_speed := 1.5
@export var player: VehicleBody3D = get_parent()
 
@onready var spring_arm: SpringArm3D = $SpringArm3D
@onready var camera_3d: Camera3D = $SpringArm3D/Camera3D
@onready var camara_2= $Camera2
var direccion = Vector3.FORWARD
var sensivilidad_horizontal = 0.1 
 
func _ready() -> void:
	if player == null:
		print("no hay vehiculo")
	set_physics_process(false)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

 
func activate() -> void:
	set_physics_process(true)
	camera_3d.current = true
 
 
func deactivate() -> void:
	set_physics_process(false)
	camera_3d.current = false
 
 
func _physics_process(delta: float) -> void:
	var current_velocity = player.linear_velocity
	current_velocity.y = 0
	if Input.is_action_just_pressed("cambiar_camara"):
		_cambio()
	if current_velocity.length() > 0.1:
		direccion = lerp(direccion, current_velocity.normalized(), smooth_speed * delta)
	#global_transform.basis = get_relations_from_direction(direccion)
	

func _cambio():
	if camara_2.current:
		camera_3d.make_current()
	else:
		camara_2.make_current()

 
#func get_relations_from_direction(direction: Vector3) -> Basis:
#	direction = direction.normalized()
#	var x_axis = direction.cross(Vector3.UP).normalized()
#	return Basis(x_axis, Vector3.UP, -direction)
	
func _input(event):
	if event is InputEventMouseMotion:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			rotate_y(deg_to_rad(-event.relative.x * sensivilidad_horizontal))
