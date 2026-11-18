extends Node3D

@onready var intro = $AnimationPlayer

func _ready() -> void:
	intro.play(("parte1"))
	await intro.animation_finished
	get_tree().change_scene_to_file("res://Escenas/escenarios/nivel1_mapa1.tscn")
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("cambiar_de_auto"):
		get_tree().change_scene_to_file("res://Escenas/escenarios/nivel1_mapa1.tscn")
