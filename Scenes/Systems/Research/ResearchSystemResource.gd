class_name ResearchSystemResource extends BaseDataSystemResource

func on_load():
    member_json = load("res://Data/StrapiData/Collections/research-categories.collection.strapi.json")
    member_string = "research_category"
    members_string = "research_categories"

    
    submember_json = load("res://Data/StrapiData/Collections/research-topics.collection.strapi.json")
    submember_string = "research_topic"
    submembers_string = "research_topics"

    super()
