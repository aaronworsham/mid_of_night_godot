class_name MysterySystemResource extends BaseDataSystemResource

func on_load():
    member_json = load("res://Data/StrapiData/Collections/mysteries.collection.strapi.json")
    member_string = "mystery"
    members_string = "mysteries"

    
    submember_json = load("res://Data/StrapiData/Collections/clues.collection.strapi.json")
    submember_string = "clue"
    submembers_string = "clues"

    super()
