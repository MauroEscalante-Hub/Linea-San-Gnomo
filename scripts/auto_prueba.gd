class_name vehiculoBase
extends VehicleBody3D
@export var start_as_player: bool = false

@onready var controlador_de_jugador = $controlador_de_jugador
@onready var movimiento = $movimiento
@onready var deteccion_de_vehiculo = $deteccion_de_vehiculo
var nuevo_vehiculo: VehicleBody3D

func _ready() -> void:
	become_npc()
	deteccion_de_vehiculo.vehiculo_encontrado.connect(respuesta_)
	if start_as_player:
		GameManager.set_player(self)

#func _process(delta):
	#if Input.is_action_pressed("cambiar_de_auto"):
		#if nuevo_vehiculo != self:
			#print("cambie de auto ahora soy ", nuevo_vehiculo.name)
			#on_hit()
		#else:
			#print("sigo en primer auto, [Soy VehiculoBase]" )

func become_player() -> void:
	controlador_de_jugador.activate()
	movimiento.movimineto_activado()


func become_npc() -> void:
	controlador_de_jugador.deactivate()
	movimiento.movimineto_desactivado()

func respuesta_(nuevo_auto: VehicleBody3D):
	nuevo_vehiculo = nuevo_auto
	
func on_hit() -> void:
	GameManager.set_player(nuevo_vehiculo)
	
