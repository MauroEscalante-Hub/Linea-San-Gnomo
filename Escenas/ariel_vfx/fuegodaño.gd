extends Node3D


@onready var fuego: GPUParticles3D = $fuego
@onready var humo: GPUParticles3D = $humo

func _ready() -> void:
	apagar()


func encender(activar: bool = true) -> void:
	if fuego:
		fuego.emitting = activar
	if humo:
		humo.emitting = activar
func apagar() -> void:
	if fuego:
		fuego.emitting = false
	if humo:
		humo.emitting = false
