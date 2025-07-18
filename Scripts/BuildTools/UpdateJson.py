
import requests
import json
import subprocess

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
        "config"    : {
            "image" : True,
            "image_name" : "portrait",
            "image_dir"  : "Portraits"
        }
    },

# #DIALOGS

#     {
#         "base_url"  : "dialogs",
#         "params"    : {
#             "populate": [
#                 "actor",
#                 "threads"
#             ]
#         },
#         "config"    :{}
#     },

# #THREADS

#     {
#         "base_url"  : "threads",
#         "params"    : {
#             "populate": [
#                 "actor",
#                 "dialog",
#                 "instructions",
#                 "instructions.thread",
#                 "instructions.clue",
#                 "instructions.mystery",
#                 "instructions.research_topic"
#             ]
#         },
#         "config"    :{}
#     },

# #MYSTERIES

#     {
#         "base_url"  : "mysteries",
#         "params"    : {
#             "populate": [
#                 "clues"
#             ]
#         },
#         "config"    :{}
#     },

# #CLUES

#     {
#         "base_url"  : "clues",
#         "params"    : {
#             "populate": [
#                 "mystery"
#             ]
#         },
#         "config"    :{}
#     },

# #RESEARCH TOPICS

#     {
#         "base_url"  : "research-topics",
#         "params"    : {
#             "populate": [
#                 "research_category"
#             ]
#         },
#         "config"    :{}
#     },     
# #RESEARCH CATEGORIES

#     {
#         "base_url"  : "research-categories",
#         "params"    : {
#             "populate": [
#                 "research_topics"
#             ]
#         },
#         "config"    :{}
#     },

# # ITEMS
#     {
#         "base_url"  : "items",
#         "params"    : {
#             "populate": [
#                 "item_portrait"
#             ]
#     },
#         "config"    :{
#             "image" : True,
#             "image_name" : "item_portrait",
#             "image_dir"  : "Items"
#         }
#     },


] 


def get_data_from_strapi(data, base_filepath, base_uri):

    base_headers = {
          'Content-Type': 'application/json'
        }

    print("Using base uri: "+ base_uri)
    r = requests.get(base_uri + data["base_url"], params=data["params"], headers=base_headers)
    print("Using full uri: "+ r.url)
    rjson = r.json()

    if "image" in data["config"]:
        download_images(rjson, data, base_filepath, base_uri)

    #Test File
    with open(base_filepath + "/Tests/StrapiData/Collections/" + "test_"+data["base_url"]+".collection.strapi.json", mode="w", encoding="utf-8") as write_file:
        json.dump(rjson, write_file)
    
    #Data File
    with open(base_filepath + "/Data/StrapiData/Collections/" + data["base_url"]+".collection.strapi.json", mode="w", encoding="utf-8") as write_file:
        json.dump(rjson, write_file)

def download_images(rjson, data, base_filepath, base_uri):
    for a in rjson["data"]:
        image_name = data["config"]["image_name"]
        if a[image_name] is not None :
            image_dir = "/Assets/" + data["config"]["image_dir"] + "/" + a[image_name]["name"]
            image_url = a[image_name]["url"]
            print("Downloading image from: "+image_url)
            img_data = requests.get(image_url).content
            with open(base_filepath + image_dir, 'wb') as handler:
                handler.write(img_data)
            print("Saved image to: "+base_filepath + image_dir)
            a[image_name]["resPath"] = "res://"+image_dir

def get_json(path,uri):
    
    print("Got uri: "+uri)
    print("Got path: "+path)
    
    for ds in data_sets:
        get_data_from_strapi(ds, path, uri)


