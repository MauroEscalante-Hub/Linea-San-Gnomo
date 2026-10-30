class_name Manager
extends Node
const METRICAS = preload("uid://ofka2avl4rqs")

signal player_changed(new_player: VehicleBody3D)
var current_player: VehicleBody3D = null
 
func _ready() -> void:
	Metrics.register_metrics(METRICAS)
	
	

func set_player(new_player: VehicleBody3D) -> void:
	if new_player == current_player:
		return
	if new_player is Tren :
		return
	if current_player != null :
		current_player.become_npc()
	# if sos iugual a tren
	# segui de largo 
	current_player = new_player
	current_player.become_player()
	current_player.remove_from_group("enemigos")
	player_changed.emit(current_player)

func jugador_muerto():
	#cosa que sea como get_tree bla bla bla para lo que tiene que ver con la pantalla de derrota
	#get_tree().change_scene_to_file("res:pantalla_derrota.tscn") algo asi supongo
	print("se murio") ##Era para probar si sale y si funca luego podemos meterle la demas escenas
	get_tree().change_scene_to_file("res://Escenas/derrota auto.tscn")
	pass
