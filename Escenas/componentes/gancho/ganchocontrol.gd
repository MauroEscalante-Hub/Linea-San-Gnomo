extends Node
@export var atraccion_base=15
@export var ray: RayCast3D
@export var soga:Node3D
@export var longitud: float = 2.0
@export var elasticidad: float = 100.0
@export var amortiguacion: float = 10.0

@onready var player: VehicleBody3D = get_parent()

var lanzado: bool = false
var target: Vector3 = Vector3.ZERO


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


func gancho_manual(_delta: float) -> void:
	var global_pos = player.global_position
	var target_direc = global_pos.direction_to(target)
	var target_dis = global_pos.distance_to(target)
	
	if target_dis > longitud:
		# Asigna la velocidad directamente al vehículo sin pasar por el sistema de fuerzas lentas
		player.linear_velocity = target_direc * elasticidad
	else:
		atraer()


func actualizar_soga() -> void:
	if not soga:
		return
		
	if not lanzado:
		soga.visible = false
		return
		
	soga.visible = true
	var distancia = player.global_position.distance_to(target)
	
	if distancia < 0.1:
		soga.visible = false
		return
		
	soga.look_at(target)
	soga.scale = Vector3(1, 1, distancia)
