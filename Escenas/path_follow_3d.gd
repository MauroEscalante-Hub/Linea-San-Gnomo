extends PathFollow3D

@export var speed :float=0.0089


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress_ratio += delta*speed
