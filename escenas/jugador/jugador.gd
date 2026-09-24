class_name Coche
extends VehicleBody3D

#@onready var detector_derecho := $RayCast_derecha
#@onready var detector_izquierdo := $RayCast_izquierda
#var pegado_a_pared :bool = false

@onready var centro_de_masa := $"centro de masa"
@onready var area_del_vehiculo = $deteccion_de_vehiculo
var auto_activado: bool = true
@export var bala : PackedScene

func _ready():
	center_of_mass = centro_de_masa.position
	area_del_vehiculo.listo_para_cambiar.connect(respuesta_)

func _physics_process(delta):
	if not auto_activado:
		return
	
	if Input.is_action_just_pressed("cambiar_de_auto"):
		print("aprete e")
		area_del_vehiculo.input_enviado.emit()
	

func respuesta_(Larespuesta: bool, nuevo_auto: VehicleBody3D):
	if Larespuesta:
		print("Ahora quiero controlar: ", nuevo_auto.name)
	else:
		print("no hay nada")
	

func  _input(event: InputEvent) -> void:
	if event.is_action_pressed("dispararbalas"):
		disparo()
		
		
func disparo():
	var balita = bala.instantiate()
	$arma.global_position = balita.global_position
	balita.direccion = -transform.basis.z.normalized()
	add_child(balita)
	

#if detector_derecho.is_colliding() and !pegado_a_pared:
		#var normal = detector_derecho.get_collision_normal()
		#var punto = detector_derecho.get_collision_point()
		#var direccion = normal.cross(Vector3.UP)
		#direccion.y = 0
		#direccion = direccion.normalized()
		#var nuevo_basis = Basis.looking_at(direccion, normal)
		#global_transform.basis = nuevo_basis
		#
		#var distancia = global_position.distance_to(punto)
		#var fuerza_pared = distancia * 300.0
#
		#apply_central_force(-normal * fuerza_pared)
		#pegado_a_pared = true
		#
	#if detector_izquierdo.is_colliding()and !pegado_a_pared:
		#var normal = detector_izquierdo.get_collision_normal()
		#var punto = detector_izquierdo.get_collision_point()
		#
		#var direccion = -normal.cross(Vector3.UP)
		#direccion.y = 0
		#direccion = direccion.normalized()
		#var nuevo_basis = Basis.looking_at(direccion, normal)
		#global_transform.basis = nuevo_basis
		#var distancia = global_position.distance_to(punto)
		#var fuerza_pared = distancia * 300.0
		#
		#apply_central_force(normal * fuerza_pared)
		#pegado_a_pared = true
	#
