class_name Manager
extends Node
 
signal player_changed(new_player: VehicleBody3D)
var current_player: VehicleBody3D = null
 
 
func set_player(new_player: VehicleBody3D) -> void:
	if new_player == current_player:
		return
	if current_player != null:
		current_player.become_npc()
	
	current_player = new_player
	current_player.become_player()
	player_changed.emit(current_player)

func jugador_muerto():
	#cosa que sea como get_tree bla bla bla para lo que tiene que ver con la pantalla de derrota
	#get_tree().change_scene_to_file("res:pantalla_derrota.tscn") algo asi supongo
	print("se murio")
	get_tree().quit()
	pass
