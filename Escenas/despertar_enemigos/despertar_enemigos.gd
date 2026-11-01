class_name Componente_activar_enemigos
extends Node3D

@export var enemigos: Array[VehicleBody3D]
var enemigo: VehicleBody3D

func _ready():
	dormir_enemigos()

func _process(delta):
	#ALGO que diga, dormir enemigos hasta que pase la funcion de despertar enemigos
	pass

func dormir_enemigos():
	for enemigo in enemigos:
		if is_instance_valid(enemigo):
			enemigo.get_node("Mov_Auto")._desactivate()

func despertar_enemigos():
	print("DESPERTANDO ENEMIGOS")

	for enemigo in enemigos:
		if is_instance_valid(enemigo):
			print("Despertando: ", enemigo.name)
			enemigo.get_node("Mov_Auto")._activate()


func _on_area_3d_body_entered(body):
	print("entro algo, soy area de activacion ", body.name)
	var vehiculo = body.get_parent()
	if vehiculo is VehicleBody3D:
		print("ES EL VEHÍCULO: ", vehiculo.name)
		despertar_enemigos()
		#
		#if vehiculo == GameManager.current_player:
			#despertar_enemigos()
