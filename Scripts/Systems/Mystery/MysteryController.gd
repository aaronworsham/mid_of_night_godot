class_name MysteryController extends Node

func _ready() -> void:
    EventManager.event_mystery_discovered.connect(mystery_discovered)
    EventManager.event_mystery_clue_discovered.connect(clue_discovered)

func mystery_discovered():
    print("Mystery Controller: Mystery Discovered")

func clue_discovered():
    print("Mystery Controller: Clue Discovered")
