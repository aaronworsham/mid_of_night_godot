extends GutTest

@onready var notebook_resource:NotebookResource = NotebookResource.new()
@onready var notebook_json:JSON = load ("res://Tests/TestNotebook.json")

func before_each():
	notebook_resource.json = notebook_json
	notebook_resource.on_load()

func test_setup():
	assert_not_null(notebook_resource.json.data)
	assert_not_null(notebook_resource._threads_dict)
