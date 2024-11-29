
import json
import urllib
from urllib.request import urlopen

data_sets = [
	{
		"full_url" : 'http://localhost:1337/api/mysteries?populate[0]=state&populate[1]=clues&populate[2]=clues.actor&populate[3]=clues.state',
		"filepath" : '/home/aaron/Godot/mid_of_night_godot/Tests/test_mysteries_strapi.json'
	},
	{
		"full_url" : 'http://localhost:1337/api/mysteries?populate[0]=state&populate[1]=clues&populate[2]=clues.actor&populate[3]=clues.state',
		"filepath" : '/home/aaron/Godot/mid_of_night_godot/Data/CaseFiles/mysteries.strapi.json'
	},
	{
		"full_url" : 'http://localhost:1337/api/notebooks?populate=state',
		"filepath" : '/home/aaron/Godot/mid_of_night_godot/Tests/test_notebooks.strapi.json'
	},
	{
		"full_url" : 'http://localhost:1337/api/notebooks?populate=state',
		"filepath" : '/home/aaron/Godot/mid_of_night_godot/Data/Notebooks/Actors/venedor_notebook.strapi.json'
	},
	{
		"full_url" : 'http://localhost:1337/api/threads?populate[0]=instructions&populate[1]=instructions.male_vo_file&populate[2]=instructions.female_vo_file&populate[3]=actor&populate[4]=instructions.actor',
		"filepath" : '/home/aaron/Godot/mid_of_night_godot/Data/Threads/threads.strapi.json'
	},
	{
		"full_url" : 'http://localhost:1337/api/threads?populate[0]=instructions&populate[1]=instructions.male_vo_file&populate[2]=instructions.female_vo_file&populate[3]=actor&populate[4]=instructions.actor',
		"filepath" : '/home/aaron/Godot/mid_of_night_godot/Tests/test_threads.strapi.json'
	},


] 

def get_data_from_strapi(url: str, filepath: str):
	r =  urlopen(url)
	bdata = r.read()
	sdata = bdata.decode("utf-8")
	jdata = json.loads(sdata)
	with open(filepath, mode="w", encoding="utf-8") as write_file:
		json.dump(jdata, write_file)

for ds in data_sets:
	get_data_from_strapi(ds["full_url"], ds["filepath"])

