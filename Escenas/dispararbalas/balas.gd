extends CharacterBody3D

var direccion: Vector3
var velocidad: float = 100


func _physics_process(delta: float) -> void:
	var colisiona := move_and_collide(direccion * velocidad * delta)
	if colisiona:
		queue_free()
		

	
func _ready() -> void:
	await get_tree().create_timer(0.5).timeout
	queue_free()
