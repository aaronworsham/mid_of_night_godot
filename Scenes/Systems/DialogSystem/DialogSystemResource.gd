class_name DialogSystemResource extends BaseDataSystemResource

func on_load():
    member_json = load("res://Data/StrapiData/Collections/dialogs.collection.strapi.json")
    member_string = "dialog"
    members_string = "dialogs"

    submember_json = load("res://Data/StrapiData/Collections/threads.collection.strapi.json")
    submember_string = "thread"
    submembers_string = "threads"
    super()
