extends Control

@onready var jugar:= $play

func _on_play_pressed() -> void:
	
	get_tree().change_scene_to_file("res://Escenas/escenarios/tutorial/tutorial.tscn")
	
	
func _on_salir_pressed() -> void:
	Metrics.export_to_csv()
	get_tree().quit()


func _on_play_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/escenas_cinematicas/escena_inicial.tscn")
	pass # Replace with function body.
