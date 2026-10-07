class_name Bala
extends CharacterBody3D

var direccion: Vector3
var velocidad: float = 100
var danio: int = 100
@onready var tiempo_ = $Timer

func set_direccion(nueva_direccion: Vector3) -> void:
	direccion = nueva_direccion
	if direccion.length() > 0.01:
		look_at(global_position + direccion, Vector3.UP)
 
 
func _physics_process(delta: float) -> void:
	global_position += direccion * velocidad * delta

func _ready() -> void:
	await get_tree().create_timer(1).timeout
	if is_instance_valid(self):
		queue_free()


func _on_area_3d_body_entered(body):
	if body.has_method("recibir_danio"):
		print("es ",body.name)
		body.recibir_danio(danio)
		queue_free()
