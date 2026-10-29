extends Node
class_name DeteccionGanchovehiculo

@export var auto_actual : VehicleBody3D = null 
@export var margendetiempo:float=0.5


signal vehiculo_enganchable


func _on_area_3d_body_entered(body) -> void:
	if body is VehicleBody3D and body != get_parent():
		auto_actual = body
		print("Hay un auto adentro del area: ", auto_actual.name)
		if body.is_in_group("enemigos") or body.is_in_group("tren"):
			vehiculo_enganchable.emit(auto_actual)
		else:
			return



func _on_area_3d_body_exited(body: Node3D) -> void:
	if body == auto_actual:
		print("Salio un auto del area: ", auto_actual.name)
		var timer = get_tree().create_timer(margendetiempo)
		await timer.timeout
	if auto_actual == body:
			auto_actual = null
			print("Se perdió el vehículo objetivo.")
