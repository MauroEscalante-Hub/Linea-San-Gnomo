class_name AutoRescateComponente
extends Node3D

@export var jugador: VehicleBody3D
@export var tiempo_requerido := 2.0
@export var desplazamiento_rescate := Vector3(10, 10, 10)


var tiempo_acumulado := 0.0

func _ready():
	if not jugador:
		var padre = get_parent()
		if padre is VehicleBody3D:
			jugador = padre

func _physics_process(delta):
	if not jugador:
		return
	
	if Input.is_action_just_pressed("levantar"):
		rescatar_vehiculo()
		tiempo_acumulado = 0.0
		return

	var sin_motor = is_zero_approx(jugador.engine_force)
	
	if sin_motor and esta_volcado():
		tiempo_acumulado += delta
		if tiempo_acumulado >= tiempo_requerido:
			rescatar_vehiculo()
			tiempo_acumulado = 0.0
	else:
		tiempo_acumulado = 0.0

func esta_volcado() -> bool:
	var direccion_techo = jugador.global_transform.basis.y
	return direccion_techo.dot(Vector3.UP) < 0.5

func rescatar_vehiculo():
	jugador.global_rotation = Vector3.ZERO
	jugador.global_position += desplazamiento_rescate
	jugador.linear_velocity = Vector3.ZERO
	jugador.angular_velocity = Vector3.ZERO

func activate():
	set_physics_process(true)
	set_process(true)

func desactivate():
	set_physics_process(false)
	set_process(false)
