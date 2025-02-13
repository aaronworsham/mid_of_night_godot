class_name BaseTestCollection extends GutTest

var collection_resource:Resource
var collection_json:JSON
var member_resource:Resource
var member_json:JSON

var cguid:String
var cname:String

func setup_collection(res, json):
    collection_resource = res
    collection_json = json
    collection_resource.json = collection_json
    collection_resource.on_load()
    cguid = collection_resource._collection_array[0]["guid"]
    cname = collection_resource._collection_array[0]["name"]

func setup_member(res, json):
    member_resource = res
    member_json = json

func base_test_setup():
    assert_not_null(collection_resource.json.data)
    assert_not_null(collection_resource._collection_array)
    
    
