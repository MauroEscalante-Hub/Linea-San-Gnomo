extends Node
@export var atraccion_base=15
@onready var ray =$"../RayCast3D"
@onready var soga=$"../soga"
@export var longitud: float = 2.0
@export var elasticidad: float = 100.0
@export var amortiguacion: float = 10.0

@onready var player: VehicleBody3D = get_parent()

var lanzado: bool = false
var target: Vector3 = Vector3.ZERO

func activate():
	set_physics_process(true)
	set_process(true)

func desactivate():
	set_physics_process(false)
	set_process(false)
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("gancho"):
		lanzar()
	if Input.is_action_just_released("gancho"):
		atraer()
		
	if lanzado:
		gancho_manual(delta)
	actualizar_soga()

func lanzar() -> void:
	if ray.is_colliding():
		target = ray.get_collision_point()
		lanzado = true
		print("[GANCHO] ¡choco!: ", target, " | con: ", ray.get_collider().name)
	else:
		print("[GANCHO] fallo: El RayCast no colisionó con ninguna superficie.")
func atraer() -> void:
	lanzado = false


func gancho_manual(delta: float) -> void:
	var global_pos = player.global_position
	var target_direc = global_pos.direction_to(target)
	var target_dis = global_pos.distance_to(target)
	var desplazamiento = target_dis - longitud
	
	if desplazamiento > 0:
		var fuerza_atraccion = target_direc * (elasticidad * desplazamiento)
		var vel_dot = player.linear_velocity.dot(target_direc)
		var fuerza_amortiguacion = target_direc * (-amortiguacion * vel_dot)
		
		var fuerza_total = (fuerza_atraccion + fuerza_amortiguacion) *(desplazamiento*atraccion_base)
		player.apply_central_force(fuerza_total*delta)
func actualizar_soga():
	if not lanzado:
		soga.visible = false
		return
		
	soga.visible = true
	
	var distancia = player.global_position.distance_to(target)
	
	soga.look_at(target)
	soga.scale = Vector3(1, 1, distancia)
