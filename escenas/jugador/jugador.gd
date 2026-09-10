extends CharacterBody3D


@export var SPEED = 5.0
var velocidad_minima = 1.0
@export var ACELERACION = 20.0
@export var FRENO = 10.0
@export var Giro = 2.0

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

# Rotación del "auto" con izquierda/derecha.
	if Input.is_action_pressed("izquierda"):
		rotate_y(Giro * delta)
	if Input.is_action_pressed("derecha"):
		rotate_y(-Giro * delta)

	# Si está apretando "frenar", decelera gradualmente hasta 0 y no procesa más movimiento.
	if Input.is_action_pressed("frenar"):
		velocity.x = move_toward(velocity.x, 0, FRENO * delta)
		velocity.z = move_toward(velocity.z, 0, FRENO * delta)
		move_and_slide()
		return

	# Ahora el movimiento es solo "avanzar" en la dirección hacia donde mira el auto.
	var avanzando = Input.is_action_pressed("avanzar")
	# Si no hay input de avanzar, igual se mueve hacia adelante a velocidad minima.
	var velocidad_objetivo: float = SPEED if avanzando else velocidad_minima
	var direccion = -transform.basis.z
	velocity.x = move_toward(velocity.x, direccion.x * velocidad_objetivo, ACELERACION * delta)
	velocity.z = move_toward(velocity.z, direccion.z * velocidad_objetivo, ACELERACION * delta)

	move_and_slide()
