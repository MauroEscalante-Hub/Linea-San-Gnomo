extends VehicleBody3D


@onready var barravida = $vidabar
@export var vida: int = 20

func _ready() -> void:
	barravida.vida_inicial(vida)

func recibir_danio(cantidad: int) -> void:
	vida -= cantidad
	if vida < 0:
		vida = 0
	if is_instance_valid(barravida):
		barravida.vida = vida
func daño():
	vida -= 2
	if vida < 0:
		vida = 0
	if is_instance_valid(barravida):
		barravida.vida = vida

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("daño"):
		daño()
