extends Node3D

@export var auto_actual : VehicleBody3D = null 
var componente_vida_enemigo: Node = null
var sprite_vida_enemigo: Sprite3D = null

signal vehiculo_encontrado(auto)

func activar() -> void:
	set_process(true)

func desactivar() -> void:
	set_process(false)
	_cambiar_visibilidad_canvas(false)

func _ready() -> void:
	_reiniciar_referencias()

func _process(_delta: float) -> void:
	if not componente_vida_enemigo or not sprite_vida_enemigo:
		return
		
	var canvas = _obtener_canvas()
	if not canvas or not canvas.visible:
		return
		
	var barra_progreso = canvas.get_node_or_null("ProgressBar")
	if barra_progreso:
		barra_progreso.value = componente_vida_enemigo.vida_actual

func _on_area_3d_body_entered(body: Node3D) -> void:
	if not (body is VehicleBody3D and body != get_parent()):
		return

	if body.name == "jugador" or body.is_in_group("jugador"):
		return
		
	auto_actual = body
	componente_vida_enemigo = body.get_node_or_null("Vida")
	sprite_vida_enemigo = body.get_node_or_null("VidaHudEnemigo")
	
	var canvas = _obtener_canvas()
	if canvas:
		canvas.visible = true # Solo se muestra si es un enemigo válido
		if componente_vida_enemigo:
			var barra_progreso = canvas.get_node_or_null("ProgressBar")
			if barra_progreso:
				barra_progreso.max_value = componente_vida_enemigo.vida_max
				barra_progreso.value = componente_vida_enemigo.vida_actual
				
	vehiculo_encontrado.emit(auto_actual)

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body != auto_actual:
		return
		
	_cambiar_visibilidad_canvas(false)
	_reiniciar_referencias()
	vehiculo_encontrado.emit(auto_actual)

func _obtener_canvas() -> Node:
	if not sprite_vida_enemigo:
		return null
	return sprite_vida_enemigo.get_node_or_null("SubViewport/Vida/canvas")

func _cambiar_visibilidad_canvas(es_visible: bool) -> void:
	var canvas = _obtener_canvas()
	if canvas:
		canvas.visible = es_visible

func _reiniciar_referencias() -> void:
	auto_actual = null
	componente_vida_enemigo = null
	sprite_vida_enemigo = null
