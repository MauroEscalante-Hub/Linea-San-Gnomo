extends VehicleBody3D

@export var max_steer := 2
@export var velocidad_de_giro := 10
@export var engine_power := 50
@onready var centro_de_masa := $"centro de masa"
@onready var detector_derecho := $RayCast_derecha
@onready var detector_izquierdo := $RayCast_izquierda
@onready var movimiento = $NavigationAgent3D
@export var jugador : VehicleBody3D
var velocity 
var pegado_a_pared :bool = false

@export var bala : PackedScene

func _ready():
	center_of_mass = centro_de_masa.position

func _physics_process(delta):
	seguimiento(self, jugador, delta)

func seguir():
	movimiento.set_target_position(jugador.position)
	var next_path_poition:Vector3 = movimiento.get_next_path_position()
	#var walk_dir = next_path_poition - global_position
	pass

func seguimiento(looker: Node3D, target: Node3D, delta):
	var forward_2d = Vector2(-global_transform.basis.z.x, -global_transform.basis.z.z).normalized()
	var target_direccion_global = (target.global_position - looker.global_position)
	var direccion2d = Vector2(target_direccion_global.x , target_direccion_global.z).normalized()
	var differencia_angulo_radianes = forward_2d.angle_to(direccion2d)
	var dot_point = forward_2d.dot(direccion2d)
	
	var steering_lerp: float;
	if dot_point > 0:
		steering_lerp = lerp(steering, clamp(-differencia_angulo_radianes , -1.0 , 1.0), velocidad_de_giro * delta)
	elif dot_point <= 0:
		steering_lerp = lerp(steering, 1.0, 1 * delta)
	steering = move_toward(steering, steering_lerp, 1 * delta)
	engine_force = 2 * engine_power
	
	
