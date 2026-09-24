class_name DeteccionDeVehiculo
extends Node3D

@export var auto_actual : VehicleBody3D = null 
signal input_enviado
signal listo_para_cambiar

func _ready():
	auto_actual = null
	input_enviado.connect(_cuando_aprieta_e)

func _on_area_3d_body_entered(body):
	if body is VehicleBody3D and body != get_parent():
		auto_actual = body
		print("Hay un auto adentro del area: ", auto_actual.name)

func _on_area_3d_body_exited(body):
	if body == auto_actual:
		print("Salio un auto del area: ", auto_actual.name)
		auto_actual = null

func _cuando_aprieta_e():
	if auto_actual:
		listo_para_cambiar.emit(true, auto_actual)
	else:
		listo_para_cambiar.emit(false, null)
