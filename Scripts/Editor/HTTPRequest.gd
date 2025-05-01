extends CanvasLayer

func _ready() -> void:
	pass

func _on_button_pressed() -> void:
	$HTTPRequest.request_completed.connect(_on_request_completed)
	$HTTPRequest.request("http://localhost:1337/api/mysteries")

func _on_request_completed( result, response_code, headers, body ):
	var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for node in save_nodes:
		# Check the node is an instanced scene so it can be instanced again during load.
		if node.scene_file_path.is_empty():
			print("persistent node '%s' is not an instanced scene, skipped" % node.name)
			continue

		# Check the node has a save function.
		if !node.has_method("save"):
			print("persistent node '%s' is missing a save() function, skipped" % node.name)
			continue

		# Call the node's save function.
		var node_data = node.call("save")

		# JSON provides a static method to serialized JSON string.
		var json_string = JSON.stringify(node_data)

		# Store the save dictionary as a new line in the save file.
		save_file.store_line(json_string)

	var json = JSON.parse_string(body.get_string_from_utf8())
	print(json)
