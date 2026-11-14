extends Node3D
@onready var texto1 = $texto1
@onready var texto2 = $texto2
@onready var texto3 = $texto3
@onready var texto4 = $texto4
@onready var texto5 = $texto5
@onready var chuchu = $AnimationPlayer
@onready var barra = $TextureProgressBar
@onready var triger1 = $trigers/tuto1
@onready var triger2 = $trigers/tuto2
@onready var triger3 = $trigers/tuto3
@onready var triger4 = $trigers/tuto4

func _on_tuto_1_body_entered(body: Node3D) -> void:
	texto1.visible = false
	texto2.visible = true
	triger1.queue_free()
	pass # Replace with function body.

func _on_tuto_2_body_entered(body: Node3D) -> void:
	texto2.visible = false
	texto3.visible = true
	triger2.queue_free()
	pass # Replace with function body.

func _on_tuto_3_body_entered(body: Node3D) -> void:
	texto3.visible = false
	texto4.visible = true
	triger3.queue_free()
	pass # Replace with function body.

func _on_tuto_4_body_entered(body: Node3D) -> void:
	texto4.visible = false
	texto5.visible = true
	triger4.queue_free()
	chuchu.play("tren_simulado")
	await chuchu.animation_finished
	texto5.visible = false
	chuchu.play("textofinal")
	await  chuchu.animation_finished
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().change_scene_to_file("res://Escenas/escenas_contexto/contexto.tscn")
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	pass # Replace with function body.
