extends GutTest

@onready var notebook_resource:NotebookResource = NotebookResource.new()
@onready var notebook_json:JSON = load ("res://Tests/TestNotebook.json")

func before_each():
	notebook_resource.json = notebook_json
	notebook_resource.on_load()

func test_setup():
	assert_not_null(notebook_resource.json.data)
	assert_not_null(notebook_resource._threads_dict)

func test_notebook_as_dict():
	var tmp:Dictionary = notebook_resource.get_threads_as_dict()
	assert_eq(tmp.keys().size(), 2)
	assert_eq(tmp.keys()[0], "hello")
