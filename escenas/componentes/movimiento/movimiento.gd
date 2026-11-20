class_name Movimiento
extends Node3D
const velocidadmulti= 2
@export var player: VehicleBody3D
@export var max_steer := 1.1
@export var velocidad_de_giro := 10
@export var engine_power := 100
@onready var aguja =$aguja
@onready var motor_marcha= $en_marcha
@onready var motor_quieto= $quieto
@onready var frenando = $freno
@export var velocidad_minima_humo: float = 12.0
@onready var humo_derrape1=$DerrapeNube/derrape
@onready var humo_derrape2=$DerrapeNube2/derrape
func _ready() -> void:
	motor_quieto.play()
	desactivarDerrape()
	
func _physics_process(delta):
	if player != GameManager.current_player:
		return
	player.steering = lerp(player.steering, Input.get_axis("derecha","izquierda") * max_steer, velocidad_de_giro * delta)
	player.engine_force = Input.get_axis("frenar", "avanzar") * engine_power
	
	movimiento_aguja(round(player.linear_velocity.length()*velocidadmulti),delta)
	print("vel: ", player.linear_velocity.length(), " | rot: ", aguja.rotation_degrees)
	print("path: ", aguja.get_path(), " | vel: ", player.linear_velocity.length(), " | rot: ", aguja.rotation_degrees)
	verificar_humo_giro(player)
	if !Input.is_action_pressed("avanzar") and !Input.is_action_pressed("frenar"):
		motor_quieto.play()
	if Input.is_action_pressed("avanzar"):
		if !motor_marcha.playing:
			motor_quieto.stop()
			motor_marcha.play()
	if !Input.is_action_pressed("avanzar"):
		motor_quieto.play()
	if Input.is_action_pressed("frenar"):
		frenando.play()
		motor_marcha.stop()
		
	
		
	
	pass

func movimineto_activado():
	set_physics_process(true)


func movimineto_desactivado():
	set_physics_process(false)
	player.steering = 0
	player.engine_force = 0

func movimiento_aguja(speed,delta):
	var rot =remap(speed,0,40,-150,135)
	aguja.rotation_degrees = lerp(aguja.rotation_degrees,rot,delta)
func activarDerrape() -> void:
	humo_derrape1.emitting = true
	humo_derrape2.emitting = true

func desactivarDerrape() -> void:
	humo_derrape1.emitting = false
	humo_derrape2.emitting = false

func verificar_humo_giro(refe: VehicleBody3D) -> void:
	var velocidad_actual = refe.linear_velocity.length()
	if velocidad_actual >= velocidad_minima_humo and abs(refe.steering) > 0.1:
		activarDerrape()
	else:
		desactivarDerrape()
