#!/bin/bash

python3 /home/aaron/Godot/mid_of_night_godot/Scripts/Python/UpdateJson.py
"/usr/local/bin/godot-engine" -s res://addons/gut/gut_cmdln.gd  -d --headless
npm run strapi export  --prefix /home/aaron/Applications/Strapi -- --no-encrypt --file /home/aaron/Godot/mid_of_night_godot/strapi_export_file