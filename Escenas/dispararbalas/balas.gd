extends CharacterBody3D

var direccion: Vector3
var velocidad: float = 100


func _physics_process(delta: float) -> void:
	velocity+= direccion * velocidad * delta
	move_and_slide()

	
func _ready() -> void:
	await get_tree().create_timer(2).timeout
	queue_free()
