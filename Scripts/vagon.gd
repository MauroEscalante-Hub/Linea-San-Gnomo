extends VehicleBody3D


@onready var barravida = $vidabar
@export var vida: int = 20
var esta_muerto: bool = false
@export var escena_derrota: String = "res://Escenas/derrota tren.tscn"

func _ready() -> void:
	barravida.vida_inicial(vida)

func morir_tren() -> void:
	esta_muerto = true
	set_physics_process(false)
	await get_tree().create_timer(3.0).timeout
	get_tree().change_scene_to_file(escena_derrota)
func recibir_danio(cantidad: int) -> void:
	if esta_muerto:
		return

	vida -= cantidad

	if is_instance_valid(barravida):
		barravida.vida = vida

	if vida <= 0:
		vida = 0
		morir_tren()
func daño() -> void:
	recibir_danio(2)

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("daño"):
		daño()
		
