extends Terrain3D
# Guardamos la última cámara registrada localmente
# Guardamos la última cámara registrada localmente
var ultima_camara: Camera3D = null

func _process(_delta: float) -> void:
	# 1. Obtenemos la cámara activa en el Viewport en este preciso frame
	var camara_activa = get_viewport().get_camera_3d()
	
	# 2. Si detectamos que la cámara cambió con respecto al frame anterior...
	if camara_activa and camara_activa != ultima_camara:
		ultima_camara = camara_activa
		
		# Forzamos un reinicio del clipmap asignando null primero
		set_camera(null)
		
		# Le asignamos la nueva cámara activa real para que mueva la alta definición aquí
		set_camera(camara_activa)
