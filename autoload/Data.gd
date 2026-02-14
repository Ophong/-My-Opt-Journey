extends Node

func load_day1_enemies() -> Array:
	var path := "res://data/day1_enemies.json"
	if not FileAccess.file_exists(path):
		push_error("Missing data file: %s" % path)
		return []

	var file := FileAccess.open(path, FileAccess.READ)
	if file == null:
		push_error("Failed to open data file: %s" % path)
		return []

	var text := file.get_as_text()
	var parsed := JSON.parse_string(text)
	if typeof(parsed) != TYPE_ARRAY:
		push_error("day1_enemies.json must contain a JSON Array.")
		return []
	return parsed
