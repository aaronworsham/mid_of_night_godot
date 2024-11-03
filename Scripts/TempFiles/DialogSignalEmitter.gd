extends Node

signal test_signal
    

func test_func():
    print("Emitting Signal")
    test_signal.emit()