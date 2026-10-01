
extends ProgressBar
@onready var timer = $timer
@onready var barradaño =$damagebar
@onready var text=$Label
var vida = 0: set = _set_vida

func _set_vida(nueva_vida):
	var vida_previa = vida
	vida = min(max_value, nueva_vida)
	value = vida
	
	if vida <= 0:
		barradaño
		text.text=str("tren muerto")
		

	if vida < vida_previa:
		timer.start()
	else:
		barradaño.value = vida

func vida_inicial(_vida):
	max_value = _vida
	value = _vida
	barradaño.max_value = _vida
	barradaño.value = _vida
	vida = _vida





func _on_timer_timeout() -> void:
	barradaño.value=vida
