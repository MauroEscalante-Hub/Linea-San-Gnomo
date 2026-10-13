
extends Node
class_name AudioManager
@onready var Audiobalas:AudioStreamPlayer3D=$"audio balas"

func play_balazo():
	Audiobalas.play()
