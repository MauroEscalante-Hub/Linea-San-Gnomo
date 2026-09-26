extends Node

signal player_changed(new_player: VehicleBody3D)

var current_player: VehicleBody3D = null


func set_player(new_player: VehicleBody3D) -> void:
	print("CURRENT PLAYER ANTES: ", current_player)
	if new_player == current_player:
		return

	if current_player != null:
		print("DESACTIVO: ", current_player.name)
		current_player.become_npc()

	current_player = new_player

	print("ACTIVO: ", current_player.name)
	current_player.become_player()

	player_changed.emit(current_player)
