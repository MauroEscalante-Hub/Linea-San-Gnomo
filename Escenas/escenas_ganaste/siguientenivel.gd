extends Node2D

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_button_button_down() -> void:
	GameManager.escenaactual+=1
	get_tree().change_scene_to_file("res://Escenas/escenarios/nivel1_mapa2/nivel1_mapa2.tscn")
	pass # Replace with function body.
