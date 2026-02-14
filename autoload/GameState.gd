extends Node

var day: int = 1
var topic: String = ""
var prep: String = ""
var practice_buff: bool = false
var item_used: bool = false

var stats: Dictionary = {
	"hp": 8,
	"fatigue": 2,
	"trust": 5,
	"buzz": 1,
	"chat_temp": 0
}

func reset_new_game() -> void:
	day = 1
	topic = ""
	prep = ""
	practice_buff = false
	item_used = false
	stats = {
		"hp": 8,
		"fatigue": 2,
		"trust": 5,
		"buzz": 1,
		"chat_temp": 0
	}

func apply_delta(delta: Dictionary) -> void:
	for key in delta.keys():
		if stats.has(key):
			var value: int = int(stats[key]) + int(delta[key])
			stats[key] = clampi(value, 0, 10)

func is_game_over() -> bool:
	return int(stats.get("hp", 0)) <= 0

func summary_text() -> String:
	return "DAY %d 결과\nHP:%d | 피로:%d | 신뢰:%d | 화제성:%d | 채팅온도:%d" % [
		day,
		int(stats.get("hp", 0)),
		int(stats.get("fatigue", 0)),
		int(stats.get("trust", 0)),
		int(stats.get("buzz", 0)),
		int(stats.get("chat_temp", 0))
	]

func to_dict() -> Dictionary:
	return {
		"day": day,
		"topic": topic,
		"prep": prep,
		"practice_buff": practice_buff,
		"item_used": item_used,
		"stats": stats.duplicate(true)
	}

func from_dict(data: Dictionary) -> void:
	day = int(data.get("day", 1))
	topic = str(data.get("topic", ""))
	prep = str(data.get("prep", ""))
	practice_buff = bool(data.get("practice_buff", false))
	item_used = bool(data.get("item_used", false))
	var loaded_stats: Dictionary = data.get("stats", {})
	for key in stats.keys():
		stats[key] = clampi(int(loaded_stats.get(key, stats[key])), 0, 10)
