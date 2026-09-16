class_name Coche
extends VehicleBody3D

@export var max_steer := 1.1
@export var velocidad_de_giro := 10
@export var engine_power := 100

func _physics_process(delta):
	steering = lerp(steering, Input.get_axis("derecha","izquierda") * max_steer, velocidad_de_giro * delta)
	engine_force = Input.get_axis("frenar", "avanzar") * engine_power
