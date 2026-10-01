class_name Arma_Jugador
extends Node3D

@export var player: VehicleBody3D
@onready var sprite_mira = $Sprite3D
@export var balas: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func activate():
	sprite_mira.visible = true
	set_process(true)

func desactivate():
	sprite_mira.visible = false
	set_process(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var camara = get_viewport().get_camera_3d()
	if camara == null:
		return
	var mouse = get_viewport().get_mouse_position()
	var origen = camara.project_ray_origin(mouse)
	var direccion = camara.project_ray_normal(mouse)
	var plano = Plane(Vector3.UP, global_position.y)
	var posicion_mira = plano.intersects_ray(origen, direccion)
	
	if posicion_mira:
		sprite_mira.global_position = posicion_mira
	
	if Input.is_action_just_pressed("dispararbalas"):
		disparo()

func disparo():
	var balita = balas.instantiate()
	get_tree().current_scene.add_child(balita)
	balita.global_position = global_position
	balita.direccion = (sprite_mira.global_position - global_position).normalized()
	
