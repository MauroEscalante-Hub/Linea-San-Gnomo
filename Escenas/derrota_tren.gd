extends Node2D
#@onready var se_mato = $sonidostren/Muerte

@export var escenario_actual = PackedScene
var escena=GameManager.escenaactual
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_salir_button_down() -> void:
	Metrics.export_to_csv()
	get_tree().change_scene_to_file("res://menu_principal.tscn")
	pass # Replace with function body.

func _on_reintentar_button_down() -> void:
	if escena==1:
		get_tree().change_scene_to_file("res://Escenas/escenarios/nivel1_mapa1.tscn")
	else:
		get_tree().change_scene_to_file("res://Escenas/escenarios/nivel1_mapa2/nivel1_mapa2.tscn")
