class_name ComponenteVida
extends Node3D

@export var player: VehicleBody3D
@export var vida_max: int = 1000
#var vida_actual: int

# Called when the node enters the scene tree for the first time.
func _ready():
	if player == null and get_parent() is VehicleBody3D:
		player = get_parent() as VehicleBody3D

func _activado():
	pass

func _desactivado():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if vida_max <= 0:
		player.queue_free()
	pass

func recibir_danio(cantidad: int):
	
	vida_max -= cantidad
	print("me dieron, ",cantidad, " y mi vida es: ", vida_max)
