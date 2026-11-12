extends Node3D
@onready var vida_hud_enemigo: Sprite3D = $VidaHudEnemigo
@onready var canvas: CanvasLayer = get_node_or_null("VidaHudEnemigo/SubViewport/Vida/canvas")

@export var auto_actual : VehicleBody3D = null 

signal vehiculo_encontrado

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	canvas.visible = true
	auto_actual = null


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is VehicleBody3D and body != get_parent():
		auto_actual = body
		print("Hay un auto adentro del area: ", auto_actual.name)
		if body.is_in_group("enemigos") or body.is_in_group("tren"):
			canvas.visible = false
		else:
			canvas.visible=true
	vehiculo_encontrado.emit(auto_actual)


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body == auto_actual:
		print("Salio un auto del area: ", auto_actual.name)
		canvas.visible = false
		auto_actual = null
		vehiculo_encontrado.emit(auto_actual)
