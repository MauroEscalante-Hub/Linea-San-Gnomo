class_name Arma_Jugador
extends Node3D

@export var disparojugador: AudioStreamPlayer3D

@export var player: VehicleBody3D
@onready var molde_de_arma = $MeshInstance3D
@onready var sprite_mira = $Sprite3D
@export var danio_del_jugador: int
@export var cadencia: float
@export var cantidad_de_balas: int
@export var balas: PackedScene
var puede_disparar := true
var disparando_hacia_atras:= false
@onready var posicion_1 = $pos_1
@onready var posicion_2 = $pos_2


func _ready():
	pass

func activate():
	sprite_mira.visible = true
	set_process(true)
	_emitir_datos_hud.call_deferred()
func _emitir_datos_hud() -> void:
	EventBus.emit_signal("tamañodecargador", cantidad_de_balas)
	EventBus.emit_signal("balasactuales", cantidad_de_balas)

func desactivate():
	sprite_mira.visible = false
	set_process(false)

func _process(delta):
	#var mouse = get_viewport().get_mouse_position()
	#var centro = get_viewport().get_visible_rect().size / 2
	#var distancia = mouse - centro
	#distancia = distancia.limit_length(5)
	#
	#sprite_mira.position = Vector3(distancia.x, 0, distancia.y)
	if Input.is_action_pressed("dispararbalas"):
		disparo()

func cambiar_direccion(cambio: bool):
	disparando_hacia_atras = cambio
	if disparando_hacia_atras:
		sprite_mira.position = Vector3(0,0, 20)
		molde_de_arma.position = Vector3(0, 0.195, 2)
	else:
		sprite_mira.position = Vector3(0,0, -20)
		molde_de_arma.position = Vector3(0, 0.195, 0.0)
		
	
func disparo():
	if not puede_disparar or cantidad_de_balas <= 0:
		return
	
	var origen = posicion_1
	if disparando_hacia_atras:
		origen = posicion_2
	
	var direccion = -player.global_transform.basis.z
	direccion.y = 0
	direccion = direccion.normalized()
	if disparando_hacia_atras:
		direccion = -direccion
	
	var balita = balas.instantiate()
	get_tree().current_scene.add_child(balita)
	
	balita.global_position = origen.global_position
	balita.duenio = player
	balita.add_collision_exception_with(player)
	balita.danio = danio_del_jugador
	balita.bala_del_jugador = true
	balita.set_direccion(direccion)
	cantidad_de_balas -= 1
	EventBus.emit_signal("balasactuales", cantidad_de_balas)
	
	puede_disparar = false
	await get_tree().create_timer(cadencia).timeout
	puede_disparar = true
	disparojugador.play()


func _on_dispa() -> void:
	pass # Replace with function body.
