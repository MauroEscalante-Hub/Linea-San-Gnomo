extends Node3D
class_name DeteccionGanchovehiculo

@export var auto_actual : VehicleBody3D = null 
@export var margendetiempo:float=0.5
@onready var player: VehicleBody3D = get_parent()
@export var area_3d: Area3D


signal vehiculo_enganchable
func activate():
	set_physics_process(true)
	set_process(true)
	area_3d.monitoring = true

func desactivate():
	set_physics_process(false)
	set_process(false)
	area_3d.monitoring = false
	auto_actual = null
func _physics_process(delta: float) -> void:
	if is_instance_valid(player):
		
		global_position = player.global_position
func _on_area_3d_body_entered(body) -> void:
	var duenio_del_area = get_parent()
	
	if body is VehicleBody3D and body != duenio_del_area:
		auto_actual = body
		
		print("[GANCHO] El vehiculo '", duenio_del_area.name, "' detecto a '", auto_actual.name, "' dentro de su area.")
		
		if body.is_in_group("enemigos") or body.is_in_group("tren"):
			vehiculo_enganchable.emit(auto_actual)
		else:
			return

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body == auto_actual:
		var duenio_del_area = get_parent()
		print("[GANCHO] '", duenio_del_area.name, "' perdio de vista a '", body.name, "'")
		
		var timer = get_tree().create_timer(margendetiempo)
		await timer.timeout
		
		if auto_actual == body:
			auto_actual = null
			print("[GANCHO] Objetivo totalmente desvinculado.")
