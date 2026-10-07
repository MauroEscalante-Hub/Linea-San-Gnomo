class_name CocheJugador
extends VehicleBody3D
@export var start_as_player: bool = false
@onready var centro_de_masa := $"centro de masa"
@onready var area_del_vehiculo = $deteccion_de_vehiculo
@onready var control_del_jugador = $controlador_de_jugador
@onready var gancho=$Ganchocontrol
var nuevo_vehiculo: VehicleBody3D
@onready var movimiento:= $movimiento
@onready var camara = $camara
@onready var arma_de_jugador = $Arma_de_jugador
@onready var componente_vida = $Vida
@onready var mov_auto = $Mov_Auto



func _ready() -> void:
	componente_vida.murio.connect(_on_vida_murio)
	area_del_vehiculo.vehiculo_encontrado.connect(_on_vehiculo_encontrado)
	become_npc()
	if start_as_player:
		GameManager.set_player(self)

func become_player() -> void:
	control_del_jugador.activate()
	movimiento.movimineto_activado()
	camara.activate()
	gancho.activate()
	arma_de_jugador.activate()
	componente_vida._activado()
	mov_auto._desactivate()

func become_npc() -> void:
	control_del_jugador.deactivate()
	movimiento.movimineto_desactivado()
	camara.deactivate()
	gancho.desactivate()
	arma_de_jugador.desactivate()
	componente_vida._desactivado()
	mov_auto._activate()

func _on_vehiculo_encontrado(nuevo_auto: VehicleBody3D) -> void:
	control_del_jugador.nuevo_vehiculo = nuevo_auto

func recibir_danio(cantidad: int):
	componente_vida.recibir_danio(cantidad)


func _on_vida_murio():
	if self == GameManager.current_player:
		GameManager.jugador_muerto()
	pass # Replace with function body.
