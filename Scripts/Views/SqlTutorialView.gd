extends Control

var database:SQLite

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	database = SQLite.new()
	database.path = "res://Data/test_sqlite_db.db"
	database.open_db()
	



func _on_insert_data_button_down() -> void:
	var data = {
		"name" : %NameEdit.text,
		"score" : int(%ScoreEdit.text),

	}
	database.insert_row("players",data)
	pass # Replace with function body.


func _on_select_data_button_down() -> void:
	print(database.select_rows("players", "score > 10", ["*"]))
	pass # Replace with function body.


func _on_update_data_button_down() -> void:
	database.update_rows(
		"players", 
		"name = '" + %NameEdit.text + "'",
		{"score": int(%ScoreEdit.text)}
	)
	pass # Replace with function body.


func _on_delete_data_button_down() -> void:
	database.delete_rows("players", "name = '"+%NameEdit.text+"'")
	pass # Replace with function body.


func _on_custom_select_button_down() -> void:
	pass # Replace with function body.


func _on_create_table_button_down() -> void:
	var table = {
		"id" : {
			"data_type":"int", 
			"primary_key": true, 
			"not_null": true,
			"auto_increment": true
		},
		"name": {"data_type": "text"},
		"score": {"data_type": "int"}
	}
	database.create_table("players", table)
	pass # Replace with function body.
