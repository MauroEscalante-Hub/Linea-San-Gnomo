class_name Coche
extends VehicleBody3D

@export var max_steer := 1.1
@export var velocidad_de_giro := 10
@export var engine_power := 100
@onready var centro_de_masa := $"centro de masa"
@onready var detector_derecho := $RayCast_derecha
@onready var detector_izquierdo := $RayCast_izquierda
var pegado_a_pared :bool = false

func _ready():
	center_of_mass = centro_de_masa.position

func _physics_process(delta):
	steering = lerp(steering, Input.get_axis("derecha","izquierda") * max_steer, velocidad_de_giro * delta)
	engine_force = Input.get_axis("frenar", "avanzar") * engine_power
	print("frente auto: ", -transform.basis.z)
	
	if pegado_a_pared:
		print("ESTOY PEGADO")
	
	if detector_derecho.is_colliding() and !pegado_a_pared:
		var normal = detector_derecho.get_collision_normal()
		var direccion = normal.cross(Vector3.UP)
		direccion.y = 0
		direccion = direccion.normalized()
		var nuevo_basis = Basis.looking_at(direccion, normal)
		global_transform.basis = nuevo_basis
		var hacia_pared = -normal
		apply_central_force(hacia_pared * 100.0)
		pegado_a_pared = true
		
	if detector_izquierdo.is_colliding()and !pegado_a_pared:
		var normal = detector_izquierdo.get_collision_normal()
		var direccion = -normal.cross(Vector3.UP)
		direccion.y = 0
		direccion = direccion.normalized()
		var nuevo_basis = Basis.looking_at(direccion, normal)
		global_transform.basis = nuevo_basis
		var hacia_pared = -normal
		apply_central_force(hacia_pared * 100.0)
		pegado_a_pared = true
	
