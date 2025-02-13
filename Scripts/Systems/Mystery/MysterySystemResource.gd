class_name MysterySystemResource extends BaseDataSystemResource

func on_load():
    member_json = load("res://Data/StrapiData/Collections/mysteries.collection.strapi.json")
    submember_json = load("res://Data/StrapiData/Collections/clues.collection.strapi.json")
    super()
