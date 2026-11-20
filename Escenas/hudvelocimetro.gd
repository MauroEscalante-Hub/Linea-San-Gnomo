extends Control
const velocidadmulti= 2
@onready var aguja =$aguja
func _physics_process(delta:float)-> void:
	var auto_actual := GameManager.current_player
	if not is_instance_valid(auto_actual) or not is_instance_valid(aguja):
		return
	movimiento_aguja(round(auto_actual.linear_velocity.length()*velocidadmulti),delta)
	print("vel: ", auto_actual.linear_velocity.length(), " | rot: ", aguja.rotation_degrees)
	print("path: ", aguja.get_path(), " | vel: ", auto_actual.linear_velocity.length(), " | rot: ", aguja.rotation_degrees)

func movimiento_aguja(speed,delta):
	var rot =remap(speed/velocidadmulti,0,40,-150,135)
	aguja.rotation_degrees = lerp(aguja.rotation_degrees,rot,delta)
