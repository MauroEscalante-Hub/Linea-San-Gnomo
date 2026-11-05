extends Area3D


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("tren"):
		get_tree().change_scene_to_file("res://Escenas/escenas_ganaste/siguientenivel.tscn")
	pass # Replace with function body.
