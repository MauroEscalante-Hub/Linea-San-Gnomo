
extends Node
class_name AudioManager
@onready var Audiobalas:AudioStreamPlayer3D=$"audio balas"
@onready var sonidotren: AudioStreamPlayer3D = $sonidotren
@onready var sonidogancho: AudioStreamPlayer3D = $sonidogancho
@onready var trenhit: AudioStreamPlayer3D = $trenhit

func play_balazo():
	Audiobalas.play()
func Sonido_tren():
	sonidotren.play()
func play_gancho():
	sonidogancho.play()
func play_trenhit():
	trenhit.play()
