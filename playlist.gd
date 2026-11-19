extends Node

@onready var bandoleros = $song_1
@onready var mission_1 = $song_2
@onready var deja_vu = $song_3
@onready var gunfight = $song_4

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reproducir_cancion()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func reproducir_cancion():
	var seleccionar = randi_range(0,3)  
	
	if seleccionar ==0:
		bandoleros.play()
	elif seleccionar ==1:
		mission_1.play()
	elif seleccionar ==2:
		deja_vu.play()
	elif seleccionar ==3:
		gunfight.play
