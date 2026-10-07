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

func _process(delta):
	var mouse = get_viewport().get_mouse_position()
	var centro = get_viewport().get_visible_rect().size / 2
	var distancia = mouse - centro
	distancia = distancia.limit_length(5)
	
	sprite_mira.position = Vector3(distancia.x, 0, distancia.y)
	
	if Input.is_action_just_pressed("dispararbalas"):
		disparo()

func disparo():
	var balita = balas.instantiate()
	get_tree().current_scene.add_child(balita)
	balita.global_position = global_position
	balita.add_collision_exception_with(player)
	
	var direccion = (sprite_mira.global_position - global_position).normalized()
	balita.set_direccion(direccion)
