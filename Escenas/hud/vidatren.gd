
extends ProgressBar
@onready var timer = $timer
@onready var barradaño =$damagebar
@onready var text=$Label
@onready var color_normal: Color = Color.WHITE
@onready var color_parpadeo: Color = Color.RED
var tween_parpadeo: Tween
var vida = 0: set = _set_vida

func _set_vida(nueva_vida):
	var vida_previa = vida
	vida = min(max_value, nueva_vida)
	value = vida
	
	if vida <= 0:
		barradaño
		detener_parpadeo()
		text.text=str("tren muerto")
	if vida < 5:
		iniciar_parpadeo()
	else:
		detener_parpadeo()

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

func iniciar_parpadeo():
	if tween_parpadeo and tween_parpadeo.is_running():
		return
		
	tween_parpadeo = create_tween().set_loops()
	tween_parpadeo.tween_property(self, "modulate", color_parpadeo, 0.2)
	tween_parpadeo.tween_property(self, "modulate", color_normal, 0.2)

func detener_parpadeo():
	if tween_parpadeo:
		tween_parpadeo.kill()
		tween_parpadeo = null
	modulate = color_normal




func _on_timer_timeout() -> void:
	barradaño.value=vida
