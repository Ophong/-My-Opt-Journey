extends Control

signal command_selected(cmd: String)

@onready var talk_button: Button = get_node("TalkButton")
@onready var joke_button: Button = get_node("JokeButton")
@onready var mod_button: Button = get_node("ModButton")
@onready var item_button: Button = get_node("ItemButton")

func _ready() -> void:
	talk_button.pressed.connect(func(): emit_signal("command_selected", "TALK"))
	joke_button.pressed.connect(func(): emit_signal("command_selected", "JOKE"))
	mod_button.pressed.connect(func(): emit_signal("command_selected", "MOD"))
	item_button.pressed.connect(func(): emit_signal("command_selected", "ITEM"))

func set_item_enabled(enabled: bool) -> void:
	item_button.disabled = not enabled
