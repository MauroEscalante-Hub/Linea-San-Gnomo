extends PathFollow3D

@export var speed :float=0.0049


func _process(delta: float) -> void:
	progress_ratio += delta*speed
