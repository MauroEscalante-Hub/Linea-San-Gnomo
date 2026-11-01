class_name Com_Mov_Automatico
extends Node3D

@export var player: VehicleBody3D
@export var radio_llegada: float = 3.0

var distancia_para_reducir: float = 15.0
var velocidad_de_giro = 3.0
var engine_power = 25.0
var tren_nuevo: VehicleBody3D
var objetivo: Node3D

func _ready():
	if player == null and get_parent() is VehicleBody3D:
		player = get_parent() as VehicleBody3D

func _activate():
	set_physics_process(true)

func _desactivate():
	set_physics_process(false)

func _physics_process(delta):
	if tren_nuevo == null:
		player.engine_force = 0.0
		return
	
	if not is_instance_valid(objetivo):
		objetivo = tren_nuevo.obtener_marker()
		if objetivo == null:
			player.engine_force = 0.0
			return
	
	seguimiento(self, objetivo, delta)

func seguimiento(looker: Node3D, target: Node3D, delta):
	var forward_2d = Vector2(-global_transform.basis.z.x, -global_transform.basis.z.z).normalized()
	var target_direccion_global = target.global_position - looker.global_position
	var distancia = Vector2(target_direccion_global.x, target_direccion_global.z).length()
	
	if distancia < radio_llegada:
		player.steering = move_toward(player.steering, 0.0, 2.0 * delta)
		player.engine_force = engine_power
		return
	
	var direccion2d = Vector2(target_direccion_global.x, target_direccion_global.z).normalized()
	var angulo = forward_2d.angle_to(direccion2d)
	var steer_objetivo = clamp(-angulo, -1.0, 1.0)
	player.steering = move_toward(player.steering, steer_objetivo, velocidad_de_giro * delta)
	
	var factor = clamp(distancia / distancia_para_reducir, 0.5, 1.0)
	player.engine_force = 2.0 * engine_power * factor
