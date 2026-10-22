extends Control
@onready var hud_bala: Sprite2D = $balas
@onready var hud_gancho: Sprite2D = $gancho


@onready var bala_equipada = true
@onready var gancho_equipado = false

func _ready() -> void:
	hud_bala.visible=true
	hud_gancho.visible=false
func _process(delta: float) -> void:
	
	hud_arma()

func hud_arma():
	if Input.is_action_just_pressed("gancho") and bala_equipada:
		hud_bala.visible = not hud_bala.visible
		hud_gancho.visible = true
		bala_equipada = false
		gancho_equipado = true
		print ("toque la r")
	if Input.is_action_just_pressed("dispararbalas") and gancho_equipado:
		hud_gancho.visible = false
		hud_bala.visible = true
		gancho_equipado = false
		bala_equipada = true
		print("toque la t")
