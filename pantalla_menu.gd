extends Control

@onready var jugar:= $play

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/grayboxing/grayboxing_escenario1.tscn")
	


func _on_salir_pressed() -> void:
	get_tree().quit()
