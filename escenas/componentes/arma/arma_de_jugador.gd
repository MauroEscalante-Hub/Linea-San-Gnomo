class_name Arma_Jugador
extends Node3D

@export var disparojugador: AudioStreamPlayer3D

@export var player: VehicleBody3D
@onready var sprite_mira = $Sprite3D
@export var danio_del_jugador: int
@export var cadencia: float
@export var cantidad_de_balas: int
@export var balas: PackedScene
var puede_disparar := true


func _ready():
	pass

func activate():
	sprite_mira.visible = true
	set_process(true)

func desactivate():
	sprite_mira.visible = false
	set_process(false)

func _process(delta):
	var mouse = get_viewport().get_mouse_position()
	var centro = get_viewport().get_visible_rect().size / 2
	var distancia = mouse - centro
	distancia = distancia.limit_length(5)
	
	sprite_mira.position = Vector3(distancia.x, 0, distancia.y)
	
	if Input.is_action_just_pressed("dispararbalas"):
		disparo()

func disparo():
	if not puede_disparar or cantidad_de_balas <= 0:
		return
	
	var balita = balas.instantiate()
	get_tree().current_scene.add_child(balita)
	balita.global_position = global_position
	balita.duenio = get_parent()
	balita.add_collision_exception_with(get_parent())
	balita.danio = danio_del_jugador
	balita.bala_del_jugador = true
	
	var direccion = (sprite_mira.global_position - global_position).normalized()
	balita.set_direccion(direccion)
	
	cantidad_de_balas -= 1
	
	puede_disparar = false
	await get_tree().create_timer(cadencia).timeout
	puede_disparar = true
	disparojugador.play()


func _on_dispa() -> void:
	pass # Replace with function body.
