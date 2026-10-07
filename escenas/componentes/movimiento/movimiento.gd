class_name Movimiento
extends Node3D

@export var player: VehicleBody3D
@export var max_steer := 1.1
@export var velocidad_de_giro := 10
@export var engine_power := 100

func _physics_process(delta):
	player.steering = lerp(player.steering, Input.get_axis("derecha","izquierda") * max_steer, velocidad_de_giro * delta)
	player.engine_force = Input.get_axis("frenar", "avanzar") * engine_power
	pass

func movimineto_activado():
	set_physics_process(true)


func movimineto_desactivado():
	set_physics_process(false)
	player.steering = 0
	player.engine_force = 0
