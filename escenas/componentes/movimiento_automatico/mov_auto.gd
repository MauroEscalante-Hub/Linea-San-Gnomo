class_name Com_Mov_Automatico
extends Node3D

@export var player: VehicleBody3D
var steering_lerp = 3
var velocidad_de_giro = 5
var engine_power = 25.0
# Called when the node enters the scene tree for the first time.
func _ready():
	if player == null and get_parent() is VehicleBody3D:
		player = get_parent() as VehicleBody3D

func _activate():
	set_physics_process(true)

func _desactivate():
	set_physics_process(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var objetivo = GameManager.current_player
	if not is_instance_valid(objetivo) or objetivo == self:
		player.engine_force = 0.0
		return
	seguimiento(self, objetivo, delta) 

func seguimiento(looker: Node3D, target: Node3D, delta):
	var forward_2d = Vector2(-global_transform.basis.z.x, -global_transform.basis.z.z).normalized()
	var target_direccion_global = (target.global_position - looker.global_position)
	var direccion2d = Vector2(target_direccion_global.x , target_direccion_global.z).normalized()
	var differencia_angulo_radianes = forward_2d.angle_to(direccion2d)
	var dot_point = forward_2d.dot(direccion2d)
	if dot_point > 0:
		steering_lerp = lerp(player.steering, clamp(-differencia_angulo_radianes , -1.0 , 1.0), velocidad_de_giro * delta)
	elif dot_point <= 0:
		steering_lerp = lerp(player.steering, 1.0, 1 * delta)
	player.steering = move_toward(player.steering, steering_lerp, 1 * delta)
	player.engine_force = 2 * engine_power
