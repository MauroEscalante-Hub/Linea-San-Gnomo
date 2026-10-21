class_name El_arma
extends Node3D


@export var player: VehicleBody3D
@export var bala: PackedScene
var cadencia := 1.0  
var danio_de_arma: int
@onready var area = $Area3D
var activa: bool
var puede_disparar := true
var objetivo_temporal: float = 0.05
var objetivo_prioritario: VehicleBody3D
var tiempo_restante: float = 0.0


func _ready() -> void:
	if player == null and get_parent() is VehicleBody3D:
		player = get_parent() as VehicleBody3D

func activate():
	activa = true
	set_physics_process(true)
	
func desactivate():
	activa = false
	set_physics_process(false)

func _physics_process(_delta):
	if not activa or not puede_disparar:
		return
	
	if tiempo_restante > 0.0:
		tiempo_restante -= _delta
		if is_instance_valid(objetivo_prioritario):
			disparo(objetivo_prioritario)
			return
	
	objetivo_prioritario = null
	for body in area.get_overlapping_bodies():
		if body is VehicleBody3D and body != get_parent():
			disparo(body)
	


func recibir_disparo_del_jugador() -> void:
	var objetivo = GameManager.current_player
	if is_instance_valid(objetivo) and objetivo is VehicleBody3D:
		objetivo_prioritario = objetivo
		tiempo_restante = objetivo_temporal


func disparo(objetivo: Node3D) -> void:
	if not activa or not puede_disparar:
		return
	
	var balita = bala.instantiate()
	get_tree().current_scene.add_child(balita)   
	balita.global_position = global_position
	balita.add_collision_exception_with(player) 
	
	var direccion := (objetivo.global_position - global_position).normalized()
	balita.set_direccion(direccion)
	balita.danio = danio_de_arma
	
	puede_disparar = false
	await get_tree().create_timer(cadencia).timeout
	puede_disparar = true
 
 
func _on_area_3d_body_entered(body: Node) -> void:
	if body is VehicleBody3D and body != get_parent():
		if tiempo_restante <= 0.0:
			disparo(body)
