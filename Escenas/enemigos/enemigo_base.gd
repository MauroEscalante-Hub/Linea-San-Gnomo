extends VehicleBody3D
@export var start_as_player: bool = false
@onready var centro_de_masa := $"centro de masa"
@onready var area_del_vehiculo = $deteccion_de_vehiculo
@onready var control_del_jugador = $controlador_de_jugador
@onready var gancho=$Ganchocontrol
var nuevo_vehiculo: VehicleBody3D
var steering_lerp = 3
var velocidad_de_giro = 5
@onready var movimiento:= $movimiento
@onready var camara = $camara
@onready var engine_power = 25.0
@onready var arma_ = $Arma
@onready var arma_de_jugador = $Arma_de_jugador
@onready var mov_auto = $Mov_Auto
@onready var componentevida = $Vida

func _ready() -> void:
	componentevida.murio.connect(_on_vida_murio)
	area_del_vehiculo.vehiculo_encontrado.connect(_on_vehiculo_encontrado)
	become_npc()
	if start_as_player:
		GameManager.set_player(self)
		

func become_player() -> void:
	control_del_jugador.activate()
	movimiento.movimineto_activado()
	camara.activate()
	gancho.activate()
	arma_.desactivate()
	arma_de_jugador.activate()
	mov_auto._desactivate()
	componentevida.activate()

func become_npc() -> void:
	control_del_jugador.deactivate()
	movimiento.movimineto_desactivado()
	camara.deactivate()
	gancho.desactivate()
	arma_.activate()
	arma_de_jugador.desactivate()
	mov_auto._activate()
	componentevida.desactivate()

func _on_vehiculo_encontrado(nuevo_auto: VehicleBody3D) -> void:
	control_del_jugador.nuevo_vehiculo = nuevo_auto
func recibir_danio(cantidad: int):
	componentevida.recibir_danio(cantidad)


func _on_vida_murio():
	if self == GameManager.current_player:
		GameManager.jugador_muerto()
	pass # Replace with function body.
