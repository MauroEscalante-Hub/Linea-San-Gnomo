class_name vehiculoBase
extends VehicleBody3D
@export var start_as_player: bool = false

@onready var controlador_de_jugador = $controlador_de_jugador
@onready var movimiento = $movimiento
@onready var deteccion_de_vehiculo = $deteccion_de_vehiculo
var nuevo_vehiculo: VehicleBody3D
@onready var camara = $camara

func _ready() -> void:
	become_npc()
	deteccion_de_vehiculo.vehiculo_encontrado.connect(_on_vehiculo_encontrado)
	if start_as_player:
		GameManager.set_player(self)

func become_player() -> void:
	controlador_de_jugador.activate()
	movimiento.movimineto_activado()
	camara.activate()


func become_npc() -> void:
	controlador_de_jugador.deactivate()
	movimiento.movimineto_desactivado()
	camara.deactivate()

func _on_vehiculo_encontrado(nuevo_auto: VehicleBody3D) -> void:
	controlador_de_jugador.nuevo_vehiculo = nuevo_auto
