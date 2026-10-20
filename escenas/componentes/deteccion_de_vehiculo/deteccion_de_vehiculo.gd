class_name DeteccionDeVehiculo
extends Node3D

@export var auto_actual : VehicleBody3D = null 
@onready var boton_saltar = $Sprite3D
signal vehiculo_encontrado

func _ready():
	boton_saltar.visible = false
	auto_actual = null

func _on_area_3d_body_entered(body):
	if body is VehicleBody3D and body != get_parent():
		auto_actual = body
		print("Hay un auto adentro del area: ", auto_actual.name)
		boton_saltar.visible = true
		vehiculo_encontrado.emit(auto_actual)
	

func _on_area_3d_body_exited(body):
	if body == auto_actual:
		print("Salio un auto del area: ", auto_actual.name)
		boton_saltar.visible = false
		auto_actual = null
		vehiculo_encontrado.emit(auto_actual)
