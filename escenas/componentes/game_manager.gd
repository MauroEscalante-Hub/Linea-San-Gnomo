class_name Manager
extends Node
const METRICAS = preload("uid://ofka2avl4rqs")

signal player_changed(new_player: VehicleBody3D)
var current_player: VehicleBody3D = null
var escenaactual:int=1
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
	#player_changed.emit(current_player)
	
	#var ruta_camara_real = "Camara/SpringArm3D/Camera3D"
	#
	#if current_player.has_node(ruta_camara_real):
		#var camara_real = current_player.get_node(ruta_camara_real) as Camera3D
		#
		#if camara_real:
			## 1. Hacemos la cámara actual
			#camara_real.make_current()
			#
			## Esperamos exactamente al siguiente frame de físicas/render
			## Esto le da tiempo a Godot de procesar el cambio de foco de la cámara.
			#await get_tree().process_frame
			#
			## 2. Buscamos el nodo del terreno
			#var terrain = get_tree().current_scene.find_child("Terrain3D", true, false)
			#if terrain and terrain.has_method("set_camera"):
				## Le quitamos la cámara vieja asignando null primero (obliga a resetear el clipmap)
				#terrain.set_camera(null) 
				## Le asignamos la nueva cámara real
				#terrain.set_camera(camara_real)
				#
				## Forzamos una actualización masiva de la geometría y mapas
				#if terrain.has_method("force_update_maps"):
					#terrain.force_update_maps()
					
					#NACHO SI LLEGAS A VER ESTO, SON LAS 23 DE LA NOCHE Y ESTAMOS DESESPERADOS
	player_changed.emit(current_player)



func jugador_muerto():
	#cosa que sea como get_tree bla bla bla para lo que tiene que ver con la pantalla de derrota
	#get_tree().change_scene_to_file("res:pantalla_derrota.tscn") algo asi supongo
	print("se murio")
	Metrics.record_add("jugador_muerto ", 1) ##Era para probar si sale y si funca luego podemos meterle la demas escenas
	Metrics.record_add("posicion_de_muerte_jugador ", current_player.global_position)
	get_tree().change_scene_to_file("res://Escenas/derrota auto.tscn")
	pass
