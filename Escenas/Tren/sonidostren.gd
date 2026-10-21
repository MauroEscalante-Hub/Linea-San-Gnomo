extends Node3D


@export var sonido_loop: AudioStreamPlayer3D
@export var sonidohit: AudioStreamPlayer3D

func _ready() -> void:
	
		sonido_loop.play()
#
#
#func _apply_loop() -> void:
	#if stream is AudioStreamWAV:
		#stream.loop_mode = AudioStreamWAV.LOOP_FORWARD if loop else AudioStreamWAV.LOOP_DISABLED
	#elif stream is AudioStreamOggVorbis:
		#stream.loop = loop



func play_hit() -> void:
	sonidohit.play()
