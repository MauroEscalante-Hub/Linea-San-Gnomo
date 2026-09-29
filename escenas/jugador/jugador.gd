class_name Coche
extends VehicleBody3D

@export var max_steer := 1.1
@export var velocidad_de_giro := 10
@export var engine_power := 100
@onready var centro_de_masa := $"centro de masa"
@onready var detector_derecho := $RayCast_derecha
@onready var detector_izquierdo := $RayCast_izquierda
var pegado_a_pared :bool = false

@export var bala : PackedScene
@onready var camara_aim:=$CameraDeApuntado
@onready var Camara_p:=$camara_player/SpringArm3D/Camera3D

func _ready():
	center_of_mass = centro_de_masa.position
	camara_aim.visible = false
	
	

func _physics_process(delta):
	steering = lerp(steering, Input.get_axis("derecha","izquierda") * max_steer, velocidad_de_giro * delta)
	engine_force = Input.get_axis("frenar", "avanzar") * engine_power
	if detector_derecho.is_colliding() and !pegado_a_pared:
		var normal = detector_derecho.get_collision_normal()
		var punto = detector_derecho.get_collision_point()
		var direccion = normal.cross(Vector3.UP)
		direccion.y = 0
		direccion = direccion.normalized()
		var nuevo_basis = Basis.looking_at(direccion, normal)
		global_transform.basis = nuevo_basis
		
		var distancia = global_position.distance_to(punto)
		var fuerza_pared = distancia * 300.0

		apply_central_force(-normal * fuerza_pared)
		pegado_a_pared = true
		
	if detector_izquierdo.is_colliding()and !pegado_a_pared:
		var normal = detector_izquierdo.get_collision_normal()
		var punto = detector_izquierdo.get_collision_point()
		
		var direccion = -normal.cross(Vector3.UP)
		direccion.y = 0
		direccion = direccion.normalized()
		var nuevo_basis = Basis.looking_at(direccion, normal)
		global_transform.basis = nuevo_basis
		var distancia = global_position.distance_to(punto)
		var fuerza_pared = distancia * 300.0
		
		apply_central_force(normal * fuerza_pared)
		pegado_a_pared = true
	

func  _input(event: InputEvent) -> void:
	if event.is_action_pressed("dispararbalas"):
		disparo()
		
	if event.is_action_pressed("apuntar") and not event.is_echo():
		camara_aim.visible = not camara_aim.visible
	if camara_aim.visible:
		camara_aim.make_current()
	else:
		Camara_p.make_current()
		

		
		
	
		
		

func disparo():
	var balita = bala.instantiate()
	$arma.global_position = balita.global_position
	balita.direccion = -transform.basis.z.normalized()
	add_child(balita)
	
