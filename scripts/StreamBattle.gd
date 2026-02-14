extends Control

@onready var chat_log: Control = get_node("ChatLog")
@onready var command_bar: Control = get_node("CommandBar")
@onready var qte: Control = get_node("QTE")

var item_used: bool = false

func _ready() -> void:
	item_used = GameState.item_used
	if command_bar.has_method("set_item_enabled"):
		command_bar.set_item_enabled(not item_used)
	call_deferred("_start_battle")

func _start_battle() -> void:
	await _run_battle()

func _run_battle() -> void:
	var enemies: Array = Data.load_day1_enemies()
	if enemies.is_empty():
		await _type_line("상황 데이터를 찾지 못했다...")
		_end_battle()
		return

	await _type_line("[방송 시작] DAY %d" % GameState.day)

	for enemy in enemies:
		await _run_enemy(enemy)
		if GameState.is_game_over():
			await _type_line("멘탈이 무너졌다... 오늘 방송은 여기까지.")
			_end_battle()
			return

	await _type_line("모든 상황을 넘겼다! 뱅종 리포트로 이동합니다.")
	_end_battle()

func _run_enemy(enemy: Dictionary) -> void:
	await _type_line("[상황] %s" % str(enemy.get("name", "Unknown")))
	for line in enemy.get("intro", []):
		await _type_line(str(line))

	for turn in enemy.get("turns", []):
		var command: String = await command_bar.command_selected
		_apply_command_effect(command)
		await _type_line("선택 커맨드: %s" % command)

		var qte_data: Dictionary = turn.get("qte", {})
		var raw_options: Array = qte_data.get("options", [])
		var options: Array[String] = []
		for option in raw_options:
			options.append(str(option))

		var selected_index: int = await qte.ask(str(enemy.get("name", "QTE")), options)
		var correct_index: int = _resolve_correct_index(qte_data)

		if GameState.practice_buff:
			await _type_line("연습 효과로 집중력이 올라갔다! (1회 보정)")
			selected_index = correct_index
			GameState.practice_buff = false

		if selected_index == correct_index:
			await _type_line("QTE 성공!")
			_apply_correct_effect(turn)
		else:
			await _type_line("QTE 실패...")
			GameState.apply_delta(turn.get("on_wrong", {}))

		await _type_line(GameState.summary_text())

func _resolve_correct_index(qte_data: Dictionary) -> int:
	var correct_map: Dictionary = qte_data.get("correct", {})
	if GameState.topic == "meme" and correct_map.has("meme"):
		return int(correct_map["meme"])
	return int(correct_map.get("default", 0))

func _apply_correct_effect(turn: Dictionary) -> void:
	if GameState.topic == "meme" and turn.has("on_correct_meme"):
		GameState.apply_delta(turn.get("on_correct_meme", {}))
	elif turn.has("on_correct_default"):
		GameState.apply_delta(turn.get("on_correct_default", {}))
	else:
		GameState.apply_delta(turn.get("on_correct", {}))

func _apply_command_effect(command: String) -> void:
	match command:
		"TALK":
			GameState.apply_delta({"trust": 1})
		"JOKE":
			GameState.apply_delta({"buzz": 1})
		"MOD":
			GameState.apply_delta({"chat_temp": -1, "buzz": -1})
		"ITEM":
			if item_used:
				return
			GameState.apply_delta({"hp": 1})
			item_used = true
			GameState.item_used = true
			if command_bar.has_method("set_item_enabled"):
				command_bar.set_item_enabled(false)

func _type_line(text: String) -> void:
	if chat_log.has_method("type_line"):
		await chat_log.type_line(text)
	else:
		chat_log.call("push_line", text)

func _end_battle() -> void:
	get_tree().change_scene_to_file("res://scenes/Report.tscn")
