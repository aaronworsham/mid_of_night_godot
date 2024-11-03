extends Node

func _ready() -> void:
    $"..".test_signal.connect(signal_connected)
    print("Signal Connected")

func signal_connected():
    print("Signal Recieved")
    