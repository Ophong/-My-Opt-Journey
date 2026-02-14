extends Control

signal choice_made(index: int)

@onready var prompt_label: Label = get_node("PromptLabel")
@onready var choice_1: Button = get_node("Choice1")
@onready var choice_2: Button = get_node("Choice2")
@onready var choice_3: Button = get_node("Choice3")

func _ready() -> void:
	visible = false
	choice_1.pressed.connect(func(): emit_signal("choice_made", 0))
	choice_2.pressed.connect(func(): emit_signal("choice_made", 1))
	choice_3.pressed.connect(func(): emit_signal("choice_made", 2))

func ask(prompt: String, options: Array[String]) -> int:
	prompt_label.text = prompt
	choice_1.text = options[0] if options.size() > 0 else "선택지 1"
	choice_2.text = options[1] if options.size() > 1 else "선택지 2"
	choice_3.text = options[2] if options.size() > 2 else "선택지 3"
	visible = true
	var selected: int = await choice_made
	visible = false
	return selected
