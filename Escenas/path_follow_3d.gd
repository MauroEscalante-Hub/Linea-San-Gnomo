extends PathFollow3D

@export var VelocidadNormal :float=0.0199
@export var Desaceleracion:float = 0.6
@export var DistanciaMax: int=15
@onready var jugador: Coche = $"../../jugador"

@onready var Locomotora: VehicleBody3D = $VehicleBody3D


func _process(delta: float):
	var distancia=Locomotora.global_position.distance_to(jugador.global_position)
	if  distancia >=  DistanciaMax:
		progress_ratio += (VelocidadNormal-(VelocidadNormal*Desaceleracion))*delta
	else:
		progress_ratio += VelocidadNormal*delta
