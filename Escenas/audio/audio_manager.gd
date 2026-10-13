
extends Node
class_name AudioManager
@onready var Audiobalas:AudioStreamPlayer3D=$"audio balas"
@onready var sonidotren: AudioStreamPlayer3D = $sonidotren

func play_balazo():
	Audiobalas.play()
func Sonido_tren():
	sonidotren.play()
