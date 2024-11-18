extends GutTest

@onready var notebook_resource:NotebookResource = NotebookResource.new()
@onready var notebook_json:JSON = load ("res://Tests/TestNotebook.json")
var t_key:String

func before_each():
	notebook_resource.json = notebook_json
	notebook_resource.on_load()
	t_key = "test_notebook_hello_thread"

func test_setup():
	assert_not_null(notebook_resource.json.data)
	assert_not_null(notebook_resource._threads_dict)
	assert_not_null(notebook_resource._threads_array)
	

func test_notebook_as_dict():
	var tmp:Dictionary = notebook_resource.get_threads_as_dict()
	assert_eq(tmp.keys().size(), 2)
	assert_eq(tmp.keys()[0], "test_notebook_hello_thread")

func test_thread_discover():
	var tmp:Array = notebook_resource.get_discovered_threads()
	assert_eq(tmp.size(), 0)
	var tmp2:bool = notebook_resource.set_discovered(t_key)
	assert_true(tmp2)
	assert_eq(tmp.size(), 1)
	var tmp3:Array = notebook_resource.get_discovered_threads()
	assert_eq(tmp3.size(), 1)
	
func test_dialogic_tupal():
	var tmp:Array = notebook_resource.get_dialogic_tupal(0)
	assert_eq(tmp[0], "vendor_timeline")
	assert_eq(tmp[1], "hello")
	
