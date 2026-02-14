extends Control

@onready var report_label: Control = get_node("ReportLabel")
@onready var exit_button: Button = get_node("ExitButton")

func _ready() -> void:
	_set_report_text(GameState.summary_text())
	SaveManager.save_game(GameState.to_dict())
	exit_button.pressed.connect(_on_exit_pressed)

func _set_report_text(text: String) -> void:
	if report_label is RichTextLabel:
		report_label.text = text
	elif report_label is Label:
		report_label.text = text

func _on_exit_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Title.tscn")
