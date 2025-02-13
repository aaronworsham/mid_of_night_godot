extends GutTest

@onready var research_topics_resource:ResearchTopicCollectionResource = ResearchTopicCollectionResource.new()
@onready var research_topics_json:JSON = load ("res://Tests/StrapiData/Collections/test_research-topics.collection.strapi.json")

var guid:String
var dname:String

func before_each():
    research_topics_resource.json = research_topics_json
    research_topics_resource.on_load()
    guid = research_topics_resource._research_topics_array[0]["guid"]
    dname = research_topics_resource._research_topics_array[0]["name"]

func test_setup():
    assert_not_null(research_topics_resource.json.data)
    assert_not_null(research_topics_resource._research_topics_dict)

func test_get_research_topic_by_guid():
    var d:Dictionary = research_topics_resource.get_research_topic_by_guid(guid)
    assert_eq(d["name"], dname)
