extends VehicleBody3D

@export var FUERZA_MOTOR_MAX := 60.0
@export var FUERZA_FRENO := 40.0
@export var ANGULO_GIRO_MAX := 0.5  # radianes
@export var VELOCIDAD_GIRO_VOLANTE := 3.0  # qué tan rápido gira el volante hacia el ángulo objetivo


func _physics_process(delta):
	var avanzando := Input.is_action_pressed("avanzar")
	var frenando := Input.is_action_pressed("frenar")

	# Motor: empuja hacia adelante mientras se apreta "avanzar".
	if avanzando and not frenando:
		engine_force = FUERZA_MOTOR_MAX
	else:
		engine_force = 0.0

	# Freno: activo mientras se apreta "frenar".
	brake = FUERZA_FRENO if frenando else 0.0

	# Dirección (steering) con izquierda/derecha, suavizado.
	var giro_objetivo := 0.0
	if Input.is_action_pressed("izquierda"):
		giro_objetivo = ANGULO_GIRO_MAX
	elif Input.is_action_pressed("derecha"):
		giro_objetivo = -ANGULO_GIRO_MAX

	steering = move_toward(steering, giro_objetivo, VELOCIDAD_GIRO_VOLANTE * delta)
