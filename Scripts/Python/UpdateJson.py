
import json
import urllib
from urllib.request import urlopen


full_url = 'http://localhost:1337/api/mysteries?populate[0]=state&populate[1]=clues&populate[2]=clues.actor&populate[3]=clues.state'

r =  urlopen(full_url)

bdata = r.read()
sdata = bdata.decode("utf-8")

print(sdata)

jdata = json.loads(sdata)

with open("/home/aaron/Godot/mid_of_night_godot/Tests/test_mysteries_strapi.json", mode="w", encoding="utf-8") as write_file:
    json.dump(jdata, write_file)
    