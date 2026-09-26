class_name CocheJugador
extends VehicleBody3D


@export var start_as_player: bool = false

@onready var centro_de_masa := $"centro de masa"
@onready var area_del_vehiculo = $deteccion_de_vehiculo
@onready var control_del_jugador = $controlador_de_jugador
@onready var movimiento = $movimiento

var nuevo_vehiculo: VehicleBody3D
@export var bala : PackedScene

func _ready() -> void:
	area_del_vehiculo.vehiculo_encontrado.connect(respuesta_)
	become_npc()
	if start_as_player:
		GameManager.set_player(self)

func _process(delta):
	if Input.is_action_just_pressed("cambiar_de_auto"):
		if nuevo_vehiculo:
			print("cambie de auto ahora soy ", nuevo_vehiculo.name)
			on_hit()
		else:
			print("sigo en primer auto")

func become_player() -> void:
	control_del_jugador.activate()
	movimiento.movimineto_activado()


func become_npc() -> void:
	control_del_jugador.deactivate()
	movimiento.movimineto_desactivado()

func respuesta_(nuevo_auto: VehicleBody3D):
	nuevo_vehiculo = nuevo_auto

func on_hit() -> void:
	GameManager.set_player(nuevo_vehiculo)



func  _input(event: InputEvent) -> void:
	if event.is_action_pressed("dispararbalas"):
		disparo()
	

func disparo():
	var balita = bala.instantiate()
	$arma.global_position = balita.global_position
	balita.direccion = -transform.basis.z.normalized()
	add_child(balita)
	
