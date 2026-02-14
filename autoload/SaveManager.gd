extends Node

const SAVE_PATH := "user://save.json"

func save_game(state: Dictionary) -> bool:
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file == null:
		push_error("Failed to open save file for write: %s" % SAVE_PATH)
		return false
	file.store_string(JSON.stringify(state))
	return true

func load_game() -> Variant:
	if not FileAccess.file_exists(SAVE_PATH):
		return null

	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file == null:
		push_error("Failed to open save file for read: %s" % SAVE_PATH)
		return null

	var text := file.get_as_text()
	var parsed := JSON.parse_string(text)
	if typeof(parsed) != TYPE_DICTIONARY:
		push_error("Save file is not a Dictionary JSON.")
		return null
	return parsed

func has_save() -> bool:
	return FileAccess.file_exists(SAVE_PATH)
