extends Node

@export var ray: RayCast3D
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


func lanzar() -> void:
	if ray.is_colliding():
		target = ray.get_collision_point()
		lanzado = true


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
		
		var fuerza_total = fuerza_atraccion + fuerza_amortiguacion
		player.apply_central_force(fuerza_total*delta)
