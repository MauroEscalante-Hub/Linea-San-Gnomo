class_name Control_de_player
extends Node

@export var vehiculo: VehicleBody3D
var nuevo_vehiculo: VehicleBody3D

func _ready() -> void:
	if vehiculo == null and get_parent() is VehicleBody3D:
		vehiculo = get_parent() as VehicleBody3D
		
	set_physics_process(false)
	set_process(false)


func activate() -> void:
	set_physics_process(true)
	set_process(true)

func deactivate() -> void:
	set_physics_process(false)
	set_process(false)

func _process(delta):
	if Input.is_action_just_pressed("cambiar_de_auto") and nuevo_vehiculo:
		GameManager.set_player(nuevo_vehiculo)
