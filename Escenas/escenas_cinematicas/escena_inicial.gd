extends Node3D

@onready var intro = $AnimationPlayer

func _ready() -> void:
	intro.play(("parte1"))
