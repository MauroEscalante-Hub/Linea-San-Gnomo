
extends TextureProgressBar
@onready var timer = $timer
@onready var barradaño =$damagebar
@onready var text=$Label
@onready var color_normal: Color = Color.WHITE
@onready var color_parpadeo: Color = Color.RED
var tween_parpadeo: Tween
var vida = 0: set = _set_vida
@onready var hud_bala = $balas
@onready var hud_gancho = $gancho
@onready var bala_equipada = true
@onready var gancho_equipado = false
@onready var aguja = $gnomo

func _process(delta: float) -> void:
	hud_arma()

func hud_arma():
	if Input.is_action_just_pressed("cambiar_a_gancho") and bala_equipada:
		hud_bala.visible = not hud_bala.visible
		hud_gancho.visible = true
		bala_equipada = false
		gancho_equipado = true
		print ("toque la r")
	if Input.is_action_just_pressed("cambiar_arma") and gancho_equipado:
		hud_gancho.visible = false
		hud_bala.visible = true
		gancho_equipado = false
		bala_equipada = true
		print("toque la t")

func velocimetro():
	aguja.rotation = 1.2/60

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
