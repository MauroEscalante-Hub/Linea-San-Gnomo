extends Node2D

@export var escenario_actual = PackedScene

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/escenarios/nivel1_mapa1.tscn")
	pass # Replace with function body.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
