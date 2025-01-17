
import requests
import json

data_sets = [
    # {
    #     "base_url" : "mysteries",
    #     "params"   : {
    #         "populate" : [
    #             "state",
    #             "clues"
    #         ]
    #     }
    # },
    # {
    #     "base_url" : "notebooks",
    #     "params"   : {
    #         "populate" : [
    #             "state"
    #         ]
    #     }
    # },
    # {
    #     "base_url" : 'threads',
    #     "params" : {
    #         "populate" : [
    #             "instructions.mystery",
    #             "instructions.clue",
    #             "instructions.next_thread"
    #         ]
    #     }

    # },

    # {
    #     "base_url" : "clues",
    #     "params"   : {
    #         "populate" : [
    #             "state",
    #             "actor",
    #             "mystery"
    #         ]
    #     }
    # }
    {
        "base_url" : "actors",
        "params"   : {
            "populate" : [
                "portrait",
                "dialog"
            ],
        },
        "has_portrait" : True
    },

    {
        "base_url"  : "dialogs",
        "params"    : {
            "populate": [
                "actor"
            ]
        },
        "has_portrait" : False
    },
    {
        "base_url"  : "threads",
        "params"    : {
            "populate": [
                "actor",
                "dialog",
                "instructions"
            ]
        },
        "has_portrait" : False
    }

] 


def get_data_from_strapi(data):
    base_uri = "http://localhost:1337/api/"
    base_filepath = '/home/aaronw/Development/mid_of_night_godot/'
    base_headers = {
          'Content-Type': 'application/json'
        }

    r = requests.get(base_uri + data["base_url"], params=data["params"], headers=base_headers)
    rjson = r.json()

    if data["has_portrait"]:
        for a in rjson["data"]:
            img_data = requests.get("http://localhost:1337/" + a["portrait"]["url"]).content
            with open(base_filepath + "Assets/portraits/" + a["portrait"]["name"], 'wb') as handler:
                handler.write(img_data)
            a["portrait"]["resPath"] = "res://Assets/portraits/" + a["portrait"]["name"]

    #Test File
    with open(base_filepath + "Tests/StrapiData/Collections/" + "test_"+data["base_url"]+".collection.strapi.json", mode="w", encoding="utf-8") as write_file:
        json.dump(rjson, write_file)
    
    #Data File
    with open(base_filepath + "Data/StrapiData/Collections/" + data["base_url"]+".collection.strapi.json", mode="w", encoding="utf-8") as write_file:
        json.dump(rjson, write_file)

for ds in data_sets:
    get_data_from_strapi(ds)
