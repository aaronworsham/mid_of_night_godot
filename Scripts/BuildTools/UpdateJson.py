
import requests
import json

data_sets = [
# ACTORS
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

#DIALOGS

    {
        "base_url"  : "dialogs",
        "params"    : {
            "populate": [
                "actor"
            ]
        },
        "has_portrait" : False
    },

#THREADS

    {
        "base_url"  : "threads",
        "params"    : {
            "populate": [
                "actor",
                "dialog",
                "instructions",
                "instructions.thread",
                "instructions.clue",
                "instructions.mystery",
                "instructions.research_topic"
            ]
        },
        "has_portrait" : False
    },

#MYSTERIES

    {
        "base_url"  : "mysteries",
        "params"    : {
            "populate": [
                "clues"
            ]
        },
        "has_portrait" : False
    },

#CLUES

    {
        "base_url"  : "clues",
        "params"    : {
            "populate": [
                "mystery"
            ]
        },
        "has_portrait" : False
    },

#RESEARCH TOPICS

    {
        "base_url"  : "research-topics",
        "params"    : {},
        "has_portrait" : False
    },

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
