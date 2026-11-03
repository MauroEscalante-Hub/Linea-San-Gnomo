extends Node2D


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://menu_principal.tscn")
	pass # Replace with function body.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
