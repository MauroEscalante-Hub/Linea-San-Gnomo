extends Node2D

# Importante importar el recurso con las métricas para poder REGISTRARLAS y luego utilizar los métodos de record.
const METRICS_RESOURCE_EXAMPLE = preload("uid://2d6dobp1lpx8")

# Botones, ignorar esto, es solo para deshabilitarlos y habiltiarlos
@onready var register_button: Button = $CanvasLayer/Control/VBoxContainer/RegisterButton
@onready var start_session_button: Button = $CanvasLayer/Control/VBoxContainer/StartSessionButton
@onready var set_grid: GridContainer = $CanvasLayer/Control/VBoxContainer/HBoxContainer/SetGrid
@onready var add: GridContainer = $CanvasLayer/Control/VBoxContainer/HBoxContainer/Add
@onready var append_array_vector_button: Button = $CanvasLayer/Control/VBoxContainer/AppendArrayVectorButton
@onready var save_to_csv_button: Button = $CanvasLayer/Control/VBoxContainer/SaveToCSVButton


func _ready() -> void:
	desactivar_botones()

func _on_register_button_pressed() -> void:
	Metrics.register_metrics(METRICS_RESOURCE_EXAMPLE)
	activar_botones()

func _on_start_session_button_pressed() -> void:
	Metrics.start_new_session()

func _on_record_metric_button_pressed() -> void:
	Metrics.record_set("jumps", 1)

func _on_record_bool_pressed() -> void:
	Metrics.record_set("died", true)

func _on_record_string_pressed() -> void:
	Metrics.record_set("map_seed", "ASD123")

func _on_record_vector_2_pressed() -> void:
	Metrics.record_set("win_2d_position", Vector2(5, 5))

func _on_record_vector_3_pressed() -> void:
	Metrics.record_set("win_3d_position", Vector3(5, 5, 5))

func _on_add_int_metric_button_pressed() -> void:
	Metrics.record_add("jumps", 1)
	
func _on_add_vector_2_metric_button_pressed() -> void:
	Metrics.record_add("win_2d_position", Vector2(randi() % 10, randi() % 10))
	
func _on_add_vector_3_pressed() -> void:
	Metrics.record_add("win_3d_position", Vector3(randi() % 10, randi() % 10, randi() % 10))

func _on_append_array_vector_button_pressed() -> void:
	Metrics.record_add("3d_heat_map", Vector3(randi() % 100, randi() % 100, randi() % 100))

func _on_save_to_csv_button_pressed() -> void:
	Metrics.export_to_csv()

func _on_open_save_folder_pressed() -> void:
	var ruta_absoluta = ProjectSettings.globalize_path(Metrics.CSV_PATH)
	var resultado = OS.shell_open(ruta_absoluta)
	if resultado != OK:
		print("no se pudo abrir el archivo")


func desactivar_botones():
	register_button.disabled = false
	start_session_button.disabled = true
	for button in set_grid.get_children():
		(button as Button).disabled = true
	for button in add.get_children():
		(button as Button).disabled = true
	append_array_vector_button.disabled = true
	save_to_csv_button.disabled = true

func activar_botones():
	register_button.disabled = true
	start_session_button.disabled = false
	for button in set_grid.get_children():
		(button as Button).disabled = false
	for button in add.get_children():
		(button as Button).disabled = false
	append_array_vector_button.disabled = false
	save_to_csv_button.disabled = false
	pass
