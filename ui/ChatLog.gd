extends Control

@onready var log: RichTextLabel = get_node("Log")

func push_line(text: String) -> void:
	log.append_text("%s\n" % text)
	log.scroll_to_line(log.get_line_count())

func type_line(text: String, cps: float = 40.0) -> void:
	var delay := 1.0 / max(cps, 1.0)
	for ch in text:
		log.append_text(ch)
		await get_tree().create_timer(delay).timeout
	log.append_text("\n")
	log.scroll_to_line(log.get_line_count())

func clear() -> void:
	log.clear()
