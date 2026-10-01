extends VehicleBody3D

@export var start_as_player: bool = false
@onready var centro_de_masa := $"centro de masa"
@onready var area_del_vehiculo = $deteccion_de_vehiculo
@onready var control_del_jugador = $controlador_de_jugador
@onready var gancho=$Ganchocontrol
@onready var Jugador= $"../jugador"
var nuevo_vehiculo: VehicleBody3D
var steering_lerp = 3
var velocidad_de_giro = 5
@onready var movimiento:= $movimiento
@onready var camara = $camara
@onready var engine_power = 25.0
@onready var arma_ = $Arma

func _ready() -> void:
	area_del_vehiculo.vehiculo_encontrado.connect(_on_vehiculo_encontrado)
	become_npc()
	if start_as_player:
		GameManager.set_player(self)
		
func _physics_process(delta: float):
	seguimiento(self, Jugador, delta)

func seguimiento(looker: Node3D, target: Node3D, delta):
	var forward_2d = Vector2(-global_transform.basis.z.x, -global_transform.basis.z.z).normalized()
	var target_direccion_global = (target.global_position - looker.global_position)
	var direccion2d = Vector2(target_direccion_global.x , target_direccion_global.z).normalized()
	var differencia_angulo_radianes = forward_2d.angle_to(direccion2d)
	var dot_point = forward_2d.dot(direccion2d)
	if dot_point > 0:
		steering_lerp = lerp(steering, clamp(-differencia_angulo_radianes , -1.0 , 1.0), velocidad_de_giro * delta)
	elif dot_point <= 0:
		steering_lerp = lerp(steering, 1.0, 1 * delta)
	steering = move_toward(steering, steering_lerp, 1 * delta)
	engine_force = 2 * engine_power

func become_player() -> void:
	control_del_jugador.activate()
	movimiento.movimineto_activado()
	camara.activate()
	gancho.activate()
	arma_.desactivate()
func become_npc() -> void:
	control_del_jugador.deactivate()
	movimiento.movimineto_desactivado()
	camara.deactivate()
	gancho.desactivate()
	arma_.activate()

func _on_vehiculo_encontrado(nuevo_auto: VehicleBody3D) -> void:
	control_del_jugador.nuevo_vehiculo = nuevo_auto
