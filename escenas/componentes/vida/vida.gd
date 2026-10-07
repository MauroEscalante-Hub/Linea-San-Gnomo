class_name ComponenteVida
extends Node3D

@export var player: VehicleBody3D
@export var vida_max: int = 500
#var vida_actual: int

# Called when the node enters the scene tree for the first time.
func _ready():
	if player == null and get_parent() is VehicleBody3D:
		player = get_parent() as VehicleBody3D

func _activado():
	set_process(true)

func _desactivado():
	set_process(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if vida_max <= 0:
		player.engine_force = 0.0
	pass

func recibir_danio(cantidad: int):
	vida_max -= cantidad
