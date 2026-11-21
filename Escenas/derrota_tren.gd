extends Node2D
#@onready var se_mato = $sonidostren/Muerte

@onready var fotomala = $Sprite2D
@onready var fotobuena = $FOTODEVERDAD
@export var escenario_actual = PackedScene
var escena=GameManager.escenaactual
func _ready() -> void:
	fotomala.visible = true
	fotobuena.visible = false
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_salir_button_down() -> void:
	Metrics.export_to_csv()
	get_tree().change_scene_to_file("res://menu_principal.tscn")
	pass # Replace with function body.

func _on_reintentar_button_down() -> void:
	Metrics._save_current_session()
	if escena==1:
		get_tree().change_scene_to_file("res://Escenas/escenarios/nivel1_mapa1.tscn")
	else:
		get_tree().change_scene_to_file("res://Escenas/escenarios/nivel1_mapa2/nivel1_mapa2.tscn")


func _on_reintentar_2_pressed() -> void:
	fotomala.visible = false
	fotobuena.visible = true
	pass # Replace with function body.
