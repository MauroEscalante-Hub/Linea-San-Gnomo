class_name ComponenteVida
extends Node3D

@export var player: VehicleBody3D
@export var vida_max: int = 100
@onready var progress_bar = $canvas/ProgressBar
@onready var canvas: CanvasLayer = $canvas

signal murio
var vida_actual: int
var muerto := false
# Called when the node enters the scene tree for the first time.
func _ready():
	if player == null and get_parent() is VehicleBody3D:
		player = get_parent() as VehicleBody3D
	vida_actual = vida_max
	progress_bar.max_value = vida_max
	progress_bar.value = vida_actual
	canvas.visible = false

func activate():
	canvas.visible = true

func desactivate():
	canvas.visible = false

func recibir_danio(cantidad: int) -> void:
	if muerto:
		return
	vida_actual = maxi(vida_actual - cantidad, 0)
	progress_bar.value = vida_actual
	
	if vida_actual == 0:
		_morir()

func _morir() -> void:
	muerto = true
	player.engine_force = 0.0
	murio.emit()
	if player != GameManager.current_player:
		player.queue_free()
