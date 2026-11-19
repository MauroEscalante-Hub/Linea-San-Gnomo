extends Node3D

@onready var finale = $Animacionfinal
func _ready() -> void:
	finale.play("final")
	await finale.animation_finished
	get_tree().change_scene_to_file("res://Escenas/ganaste_2d.tscn")
