extends Control

@onready var day_label: Label = get_node("DayLabel")
@onready var topic_option: OptionButton = get_node("TopicOption")
@onready var prep_option: OptionButton = get_node("PrepOption")
@onready var start_stream_button: Button = get_node("StartStreamButton")
@onready var stats_label: Label = get_node("StatsLabel")

func _ready() -> void:
	day_label.text = "DAY %d 준비" % GameState.day
	topic_option.clear()
	prep_option.clear()
	topic_option.add_item("잔잔 토크", 0)
	topic_option.add_item("밈 실험", 1)
	prep_option.add_item("휴식", 0)
	prep_option.add_item("연습", 1)
	stats_label.text = GameState.summary_text()
	start_stream_button.pressed.connect(_on_start_stream_pressed)

func _on_start_stream_pressed() -> void:
	var topic_id := topic_option.get_selected_id()
	var prep_id := prep_option.get_selected_id()

	GameState.topic = "calm" if topic_id == 0 else "meme"
	GameState.prep = "rest" if prep_id == 0 else "practice"
	GameState.practice_buff = (GameState.prep == "practice")
	GameState.item_used = false

	if GameState.topic == "calm":
		GameState.apply_delta({"trust": 1})
	else:
		GameState.apply_delta({"buzz": 1, "trust": -1})

	if GameState.prep == "rest":
		GameState.apply_delta({"fatigue": -2})

	get_tree().change_scene_to_file("res://scenes/StreamBattle.tscn")
