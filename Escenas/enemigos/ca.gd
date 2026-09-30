extends CharacterBody3D

const SPEED = 15.0
@onready var seguimiento := $NavigationAgent3D
@onready var jugador := $"../jugador"

func _physics_process(delta: float) -> void:
	cosa()
	move_and_slide()

func cosa():
	seguimiento.set_target_position(jugador.position)
	var next_path_position:Vector3 = seguimiento.get_next_path_position()
	var walk = next_path_position - global_position
	
	if walk.length() > 0.2:
		velocity = walk.normalized() * SPEED
	else :
		velocity = Vector3.ZERO
