extends Node
@export var atraccion_base=15
@onready var ray =$"../RayCast3D"
@onready var soga=$"../soga"
@onready var detector=$"../DeteccionGancho"

@export var longitud: float = 2.0
@export var elasticidad: float = 100.0
@export var amortiguacion: float = 10.0
@export var sonido_gancho: AudioStreamPlayer3D
@export var gancho:bool=false
@export var velocidad_maxima: float = 35.0
#@export var fuerza_maxima_permitida = 9000.0
@export var cooldown: float = 5.0



@onready var player: VehicleBody3D = get_parent()
var cooldown_actual: float = 0.0
var lanzado: bool = false
var target: Vector3 = Vector3.ZERO
var auto_objetivo: VehicleBody3D = null

func activate():
	set_physics_process(true)
	set_process(true)
	if detector and not detector.vehiculo_enganchable.is_connected(vehiculo_enganchable):
		detector.vehiculo_enganchable.connect(vehiculo_enganchable)

func desactivate():
	set_physics_process(false)
	set_process(false)
	atraer()
	if detector and detector.vehiculo_enganchable.is_connected(vehiculo_enganchable):
		detector.vehiculo_enganchable.disconnect(vehiculo_enganchable)
func _physics_process(delta: float) -> void:
	if cooldown_actual > 0:
		cooldown_actual -= delta
	if Input.is_action_just_pressed("gancho") and not lanzado and cooldown_actual <= 0:
		lanzar()
		
	if Input.is_action_just_released("gancho")and lanzado:
		atraer()
		
	if lanzado:
		if is_instance_valid(auto_objetivo):
			target = auto_objetivo.global_position
		gancho_manual(delta)
		
	actualizar_soga()
func vehiculo_enganchable(vehiculo: VehicleBody3D) -> void:
	auto_objetivo = vehiculo


func lanzar() -> void:
	if is_instance_valid(auto_objetivo):
		target = auto_objetivo.global_position
		lanzado = true
		if sonido_gancho: sonido_gancho.play()
		print("[GANCHO] ¡Enganchado! Velocidad lineal al lanzar: ", player.linear_velocity, " | Rapidez: ", player.linear_velocity.length())
		return
		
	if ray.is_colliding():
		target = ray.get_collision_point()
		lanzado = true
		
		sonido_gancho.play()
		print("[GANCHO] ¡choco!: ", target, " | con: ", ray.get_collider().name)
	else:
		print("[GANCHO] fallo: El RayCast no colisionó con ninguna superficie.")
func atraer() -> void:
	if lanzado:cooldown_actual = cooldown
	lanzado = false
	auto_objetivo = null


func gancho_manual(delta: float) -> void:
	var global_pos = player.global_position
	var target_direc = global_pos.direction_to(target)
	var target_dis = global_pos.distance_to(target)
	var desplazamiento = target_dis - longitud

	
	if desplazamiento > 0:
		desplazamiento = min(desplazamiento, 15)
		var fuerza_atraccion = target_direc * (elasticidad * desplazamiento)
		var vel_dot = player.linear_velocity.dot(target_direc)
		var fuerza_amortiguacion = target_direc * (-amortiguacion * vel_dot)
		
		var fuerza_total = (fuerza_atraccion + fuerza_amortiguacion) *(desplazamiento*atraccion_base)
		#if fuerza_total.length() > fuerza_maxima_permitida:
			#fuerza_total = fuerza_total.normalized() * fuerza_maxima_permitida
		player.apply_central_force(fuerza_total*delta)
		if player.linear_velocity.length() > velocidad_maxima:
			player.linear_velocity = player.linear_velocity.normalized() * velocidad_maxima
func actualizar_soga():
	if not lanzado:
		soga.visible = false
		return
		
	soga.visible = true
	
	var distancia = player.global_position.distance_to(target)
	
	soga.look_at(target)
	soga.scale = Vector3(1, 1, distancia)
