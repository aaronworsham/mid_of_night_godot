extends GutTest

@onready var research_categories_resource:ResearchCategoryCollectionResource = ResearchCategoryCollectionResource.new()
@onready var research_categories_json:JSON = load ("res://Tests/StrapiData/Collections/test_research-categories.collection.strapi.json")

var guid:String
var dname:String

func before_each():
    research_categories_resource.json = research_categories_json
    research_categories_resource.on_load()
    guid = research_categories_resource._research_categories_array[0]["guid"]
    dname = research_categories_resource._research_categories_array[0]["name"]

func test_setup():
    assert_not_null(research_categories_resource.json.data)
    assert_not_null(research_categories_resource._research_categories_dict)

func test_get_research_category_by_guid():
    var d:Dictionary = research_categories_resource.get_research_category_by_guid(guid)
    assert_eq(d["name"], dname)
