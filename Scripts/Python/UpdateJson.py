
import requests
import json

data_sets = [
    {
        "base_url" : "mysteries",
        "params"   : {
            "populate" : [
                "state",
                "clues"
            ]
        }
    },
    {
        "base_url" : "notebooks",
        "params"   : {
            "populate" : [
                "state"
            ]
        }
    },
    {
        "base_url" : 'threads',
        "params" : {
            "populate" : [
                "instructions.mystery",
                "instructions.clue",
                "instructions.next_thread"
            ]
        }

    },

    {
        "base_url" : "clues",
        "params"   : {
            "populate" : [
                "state",
                "actor",
                "mystery"
            ]
        }
    }
] 


def get_data_from_strapi(data):
    base_uri = "http://localhost:1337/api/"
    base_filepath = '/home/aaron/Godot/mid_of_night_godot/'
    base_headers = {
          'Content-Type': 'application/json'
        }

    r = requests.get(base_uri + data["base_url"], params=data["params"], headers=base_headers)

    #Test File
    with open(base_filepath + "Tests/" + "test_"+data["base_url"]+".strapi.json", mode="w", encoding="utf-8") as write_file:
        json.dump(r.json(), write_file)
    
    #Data File
    with open(base_filepath + "Data/" + data["base_url"]+".strapi.json", mode="w", encoding="utf-8") as write_file:
        json.dump(r.json(), write_file)

for ds in data_sets:
    get_data_from_strapi(ds)
