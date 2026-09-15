class_name Coche
extends VehicleBody3D

@export var max_steer := 1.0
@export var engine_power := 300

func _physics_process(delta):
	steering = move_toward(steering, Input.get_axis("derecha","izquierda") * max_steer, delta * 10)
	engine_force = Input.get_axis("frenar", "avanzar") * engine_power
