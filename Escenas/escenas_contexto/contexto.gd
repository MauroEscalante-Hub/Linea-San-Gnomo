extends Sprite3D

@onready var boton = $Button

func ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/escenarios/nivel1_mapa1.tscn")
	pass # Replace with function body.
