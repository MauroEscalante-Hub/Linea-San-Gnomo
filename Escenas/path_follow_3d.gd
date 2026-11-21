extends PathFollow3D

@export var VelocidadNormal :float 
@export var Desaceleracion:float = 0.6
@export var DistanciaMax: int=15
@export var barrita_tren : TextureProgressBar
@onready var jugador: VehicleBody3D = $"../../jugador"
@onready var Locomotora: VehicleBody3D = $VehicleBody3D
@onready var via = $"../CSGPolygon3D"
#@onready var barra_de_tren = TextureProgressBar
@onready var progreso = $"."

#func _ready() -> void:
#	via.global_position = Vector3(-135, 0, 445)

func _process(delta: float):
	#via.global_position = Vector3(-135, 0, 445)
	var distancia=Locomotora.global_position.distance_to(GameManager.current_player.global_position)
	if  distancia >=  DistanciaMax:
		progress_ratio += (VelocidadNormal-(VelocidadNormal*Desaceleracion))*delta
	else:
		progress_ratio += VelocidadNormal*delta
		
	barrita_tren.value = progreso.progress / 15
