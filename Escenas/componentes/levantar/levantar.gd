class_name AutoRescateComponente
extends Node3D

@export var jugador: VehicleBody3D
@export var tiempo_requerido := 2.0
@export var desplazamiento_rescate := Vector3(0, 0, 0)
var tiempo_acumulado := 0.0

func _ready():
	if jugador == null and get_parent() is VehicleBody3D:
		jugador = get_parent() as VehicleBody3D

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
	return direccion_techo.dot(Vector3.UP) < 0.0

func rescatar_vehiculo():
	var rotacion_y = jugador.global_rotation.y
	
	jugador.global_rotation = Vector3(0, rotacion_y, 0)
	jugador.global_position.y += desplazamiento_rescate.y
	jugador.linear_velocity = Vector3.ZERO
	jugador.angular_velocity = Vector3.ZERO

func activate():
	set_physics_process(true)

func desactivate():
	set_physics_process(false)
