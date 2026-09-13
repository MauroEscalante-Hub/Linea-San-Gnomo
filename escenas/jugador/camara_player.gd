extends Node3D

@export var smooth_speed := 0.9
@export var player := CharacterBody3D
var direccion = Vector3.FORWARD

func _ready():
	if player == null:
		return

func _physics_process(delta):
	var current_velocity = get_parent().velocity
	current_velocity.y = 0

	if current_velocity.length() > 0.1:
		direccion = lerp(direccion, current_velocity.normalized(), smooth_speed * delta)

	global_transform.basis = get_relations_from_direction(direccion)


func get_relations_from_direction(direction: Vector3) -> Basis:
	direction = direction.normalized()
	var x_axis = direction.cross(Vector3.UP).normalized()
	return Basis(x_axis, Vector3.UP, -direction)
