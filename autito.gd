extends vehiculoBase


# Called when the node enters the scene tree for the first time.
func _ready():
	become_npc()
	deteccion_de_vehiculo.vehiculo_encontrado.connect(respuesta_)
	if start_as_player:
		GameManager.set_player(self)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
