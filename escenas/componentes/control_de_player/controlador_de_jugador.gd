extends Node

@export var vehiculo: VehicleBody3D


func _ready() -> void:
	if vehiculo == null and get_parent() is VehicleBody3D:
		vehiculo = get_parent() as VehicleBody3D
		
	set_physics_process(false)


func activate() -> void:
	set_physics_process(true)

func deactivate() -> void:
	set_physics_process(false)
