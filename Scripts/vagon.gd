class_name Tren
extends VehicleBody3D


@onready var barravida = $vidabar
@export var vida: int = 20
@onready var marcadores: Array[Marker3D] = []
var esta_muerto: bool = false

@onready var sonidostren: Node3D = $sonidostren



func _ready() -> void:
	barravida.vida_inicial(vida)
	for i in $marcador.get_children():
		marcadores.append(i)

func morir_tren() -> void:
	esta_muerto = true
	set_physics_process(false)
	await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_file("res://Escenas/derrota tren.tscn")

func recibir_danio(cantidad: int, es_del_jugador: bool = false) -> void:
	if esta_muerto:
		return
	vida -= cantidad
	sonidostren.play_hit()

	if is_instance_valid(barravida):
		barravida.vida = vida

	if vida <= 0:
		vida = 0
		morir_tren()
func daño() -> void:
	recibir_danio(200)
	

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("daño"):
		daño()
		sonidostren.play_hit()

func obtener_marker():
	if marcadores.is_empty():
		return null
	return marcadores.pick_random()
