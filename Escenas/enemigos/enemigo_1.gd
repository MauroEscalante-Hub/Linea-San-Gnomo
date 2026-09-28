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
	var walk_dir = next_path_poition - global_position
	pass

func seguimiento(looker: Node3D, target: Node3D, delta):
	#var jugador_posicion = target.global_position
	var disntacia = looker.global_position.distance_to(target.global_position)
	var x_target = looker.global_position.x - target.global_position.x
	var z_target = looker.global_position.z - target.global_position.z
	#looker.global_rotation.y = atan2(x_target, z_target)
	var forward_2d = Vector2(global_transform.basis.z.x, global_transform.basis.z.z)
	var direccion = (target.global_position - looker.global_position)
	var direccion2d = Vector2(direccion.x , direccion.z)
	var angulo_radianes = forward_2d.angle_to(direccion2d)
	print("angulo", angulo_radianes)
	steering = lerp(steering, clamp(angulo_radianes , -1.0 , 1.0) * max_steer, velocidad_de_giro * delta)
	#print("rotacion", steering)
	#engine_force = 3 * engine_power
	if disntacia > 0:
		engine_force = 2 * engine_power
		#print("Distancia" , disntacia)
	else:
		engine_power = 0
		#print("Lo vi")
	
#steering, atan2(x_target, z_target) * max_steer,
