extends Control

@onready var new_game_button: Button = get_node("NewGameButton")
@onready var continue_button: Button = get_node("ContinueButton")

func _ready() -> void:
	new_game_button.pressed.connect(_on_new_game_pressed)
	continue_button.pressed.connect(_on_continue_pressed)
	continue_button.disabled = not SaveManager.has_save()

func _on_new_game_pressed() -> void:
	GameState.reset_new_game()
	SaveManager.save_game(GameState.to_dict())
	get_tree().change_scene_to_file("res://scenes/Prep.tscn")

func _on_continue_pressed() -> void:
	var loaded := SaveManager.load_game()
	if loaded == null:
		continue_button.disabled = true
		return
	GameState.from_dict(loaded)
	get_tree().change_scene_to_file("res://scenes/Prep.tscn")
