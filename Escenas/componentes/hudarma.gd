extends Control
@onready var hud_bala: Sprite2D = $balas
@onready var hud_gancho: Sprite2D = $gancho
@onready var cooldown: Label = $Label


@onready var bala_equipada = true
@onready var gancho_equipado = true
var escala_original: Vector2
var tween_actual: Tween

func _ready() -> void:
	hud_bala.visible=true
	hud_gancho.visible=true
	cooldown.visible=false
	EventBus.cooldown_cambiado.connect(_on_cooldown_cambiado)
	EventBus.actualizar_cooldown.connect(_on_actualizar_cooldown)
	EventBus.reset_gancho.connect(_on_reset_gancho)
	if hud_gancho:
		escala_original = hud_gancho.scale
	EventBus.objetivo_cambiado.connect(_on_objetivo_cambiado)
func _process(delta: float) -> void:
	
	hud_arma()

func hud_arma():
	if Input.is_action_just_pressed("gancho") and bala_equipada:
		#hud_bala.visible = not hud_bala.visible
		hud_gancho.visible = true
		bala_equipada = false
		gancho_equipado = true
		print ("toque la r")
	if Input.is_action_just_pressed("dispararbalas") and gancho_equipado:
		#hud_gancho.visible = false
		hud_bala.visible = true
		gancho_equipado = false
		bala_equipada = true
		print("toque la t")
func _on_objetivo_cambiado(tiene_objetivo: bool) -> void:
	if not hud_gancho:
		return

	if tween_actual and tween_actual.is_running():
		tween_actual.kill()

	var escala_final = escala_original + Vector2(0.03, 0.03) if not tiene_objetivo else escala_original
	
	tween_actual = create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween_actual.tween_property(hud_gancho, "scale", escala_final, 0.03)



func _on_cooldown_cambiado(activo: bool) -> void:
	print("[HUD] _on_cooldown_cambiado recibido con valor: ", activo)
	if not hud_gancho:
		return
		
	if tween_actual and tween_actual.is_running():
		tween_actual.kill()
		
	tween_actual = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	var alfa_final = 0.4 if activo else 1.0
	tween_actual.tween_property(hud_gancho, "modulate:a", alfa_final, 0.2)
func _on_actualizar_cooldown(tiempo_restante: float) -> void:
	if not cooldown:
		return
		
	var segundos: int = ceili(tiempo_restante)
	
	if segundos > 0:
		cooldown.visible = true
		cooldown.text = str(segundos)
	else:
		cooldown.visible = false
func _on_reset_gancho() -> void:
	if tween_actual and tween_actual.is_running():
		tween_actual.kill()
		
	if hud_gancho:
		hud_gancho.scale = escala_original
		hud_gancho.modulate.a = 1.0 
		
	if cooldown:
		cooldown.visible = false 
