class_name DialogSystemResource extends BaseDataSystemResource

func on_load():
    member_json = load("res://Data/StrapiData/Collections/dialogs.collection.strapi.json")
    submember_json = load("res://Data/StrapiData/Collections/threads.collection.strapi.json")
    super()
