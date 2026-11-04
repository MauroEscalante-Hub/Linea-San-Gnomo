class_name Componente_activar_enemigos
extends Area3D

@export var enemigos: Array[VehicleBody3D] = []
var activado:= false

func _ready():
	print("soy area ", name)
	dormir_enemigos()


func dormir_enemigos():
	for enemigo in enemigos:
		if is_instance_valid(enemigo):
			print("durmuiendo ", enemigo)
			var movimiento = enemigo.get_node_or_null("Mov_Auto")
			if movimiento:
				movimiento._desactivate()

func despertar_enemigos():
	if activado:
		return
	
	activado = true
	print("DESPERTANDO ENEMIGOS")
	for enemigo in enemigos:
		if is_instance_valid(enemigo):
			print("Despertando: ", enemigo.name)
			var movimiento = enemigo.get_node_or_null("Mov_Auto")
			if movimiento:
				movimiento._activate()
	
	set_deferred("monitoring", false)


func _on_body_entered(body):
	print("entro algo, soy area de activacion ", body.name)
	if body is VehicleBody3D:
		print("ES EL VEHÍCULO: ", body.name)
		despertar_enemigos()
