class_name CocheJugador
extends VehicleBody3D

#@onready var detector_derecho := $RayCast_derecha
#@onready var detector_izquierdo := $RayCast_izquierda
#var pegado_a_pared :bool = false

@onready var centro_de_masa := $"centro de masa"
@onready var area_del_vehiculo = $deteccion_de_vehiculo
<<<<<<< Updated upstream
signal nuevo_auto
var auto_activado: bool = true
@export var bala : PackedScene
=======
@onready var control_del_jugador = $controlador_de_jugador
@onready var gancho=$Ganchocontrol
var nuevo_vehiculo: VehicleBody3D
@onready var movimiento:= $movimiento
@export var bala : PackedScene
@onready var camara = $camara
>>>>>>> Stashed changes

func _ready():
	center_of_mass = centro_de_masa.position
	area_del_vehiculo.listo_para_cambiar.connect(respuesta_)

<<<<<<< Updated upstream
func _physics_process(_delta):
	if not auto_activado:
		return
	
	if Input.is_action_just_pressed("cambiar_de_auto"):
		print("aprete e")
		area_del_vehiculo.input_enviado.emit()
	

func respuesta_(Larespuesta: bool, Unauto: VehicleBody3D):
	if Larespuesta:
		print("Ahora quiero controlar: ", Unauto.name)
		
	else:
		print("no hay auto")
	
=======
func _ready() -> void:
	area_del_vehiculo.vehiculo_encontrado.connect(_on_vehiculo_encontrado)
	become_npc()
	if start_as_player:
		GameManager.set_player(self)

func become_player() -> void:
	control_del_jugador.activate()
	movimiento.movimineto_activado()
	camara.activate()
	gancho.activate()

func become_npc() -> void:
	control_del_jugador.deactivate()
	movimiento.movimineto_desactivado()
	camara.deactivate()
	gancho.desactivate()

func _on_vehiculo_encontrado(nuevo_auto: VehicleBody3D) -> void:
	control_del_jugador.nuevo_vehiculo = nuevo_auto
>>>>>>> Stashed changes

func  _input(event: InputEvent) -> void:
	if event.is_action_pressed("dispararbalas"):
		disparo()
<<<<<<< Updated upstream
		
		
=======

>>>>>>> Stashed changes
func disparo():
	var balita = bala.instantiate()
	$arma.global_position = balita.global_position
	balita.direccion = -transform.basis.z.normalized()
	add_child(balita)
<<<<<<< Updated upstream
	

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
=======
>>>>>>> Stashed changes
