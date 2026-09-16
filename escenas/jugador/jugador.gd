class_name Coche
extends VehicleBody3D

@export var max_steer := 1.1
@export var velocidad_de_giro := 10
@export var engine_power := 100
@onready var centro_de_masa := $"centro de masa"
@onready var detector_derecho := $RayCast_derecha
@onready var detector_izquierdo := $RayCast_izquierda
func _ready():
	center_of_mass = centro_de_masa.position

func _physics_process(delta):
	steering = lerp(steering, Input.get_axis("derecha","izquierda") * max_steer, velocidad_de_giro * delta)
	engine_force = Input.get_axis("frenar", "avanzar") * engine_power
	
	if detector_derecho.is_colliding():
		#print("se detecto algo, soy derecho")
		var normal = detector_derecho.get_collision_normal()
		var direccion_pared = normal.cross(Vector3.UP)
		
		print("[velocidad] ",linear_velocity)
		print("[direccion pared] ", direccion_pared)
	
	if detector_izquierdo.is_colliding():
		#print("se detecto algo, soy izquierdo")
		#var normal = detector_izquierdo.get_collision_normal()
		#var direccion = normal.cross(Vector3.UP)
		#print(direccion)
		print("[izquierdo] ",linear_velocity)
