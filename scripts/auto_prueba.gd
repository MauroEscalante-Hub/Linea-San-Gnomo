class_name vehiculoBase
extends VehicleBody3D
@export var start_as_player: bool = false

@onready var controlador_de_jugador = $controlador_de_jugador
@onready var movimiento = $movimiento
@onready var deteccion_de_vehiculo = $deteccion_de_vehiculo

func _ready() -> void:
	become_npc()
	if start_as_player:
		GameManager.set_player(self)


func become_player() -> void:
	controlador_de_jugador.activate()
	movimiento.movimineto_activado()


func become_npc() -> void:
	controlador_de_jugador.deactivate()
	movimiento.movimineto_desactivado()


func on_hit() -> void:
	GameManager.set_player(self)
