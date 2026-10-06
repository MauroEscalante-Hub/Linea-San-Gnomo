class_name El_arma
extends Node3D

@export var player: VehicleBody3D
@export var bala: PackedScene
@export var cadencia := 1.0  
@onready var area = $Area3D
var activa: bool
var puede_disparar := true
@onready var mesh_instance_3d = $MeshInstance3D

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
	for body in area.get_overlapping_bodies():
		if body is VehicleBody3D and body != get_parent():
			disparo(body)

func disparo(objetivo: Node3D) -> void:
	if not activa or not puede_disparar:
		return
	var balita = bala.instantiate()
	get_tree().current_scene.add_child(balita)   
	balita.global_position = global_position
	balita.add_collision_exception_with(player) 
	var direccion := (objetivo.global_position - global_position).normalized()
	balita.set_direccion(direccion)
	
	puede_disparar = false
	await get_tree().create_timer(cadencia).timeout
	puede_disparar = true
 
 
func _on_area_3d_body_entered(body: Node) -> void:
	if body is VehicleBody3D and body != get_parent():
		disparo(body)
