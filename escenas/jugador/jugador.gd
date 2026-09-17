class_name Coche
extends VehicleBody3D

@export var max_steer := 1.1
@export var velocidad_de_giro := 10
@export var engine_power := 100
@onready var centro_de_masa := $"centro de masa"

@export var bala : PackedScene

func _ready():
	center_of_mass = centro_de_masa.position

func _physics_process(delta):
	steering = lerp(steering, Input.get_axis("derecha","izquierda") * max_steer, velocidad_de_giro * delta)
	engine_force = Input.get_axis("frenar", "avanzar") * engine_power

func  _input(event: InputEvent) -> void:
	if event.is_action_pressed("dispararbalas"):
		disparo()
		
		
func disparo():
	var balita = bala.instantiate()
	balita.global_position = $arma.global_position
	balita.direccion = -transform.basis.z.normalized()
	add_child(balita)
