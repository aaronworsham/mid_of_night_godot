@tool extends Node

@export var radius: float = 32.0:
	set(x):
		radius = x
		print("Hi")

@export_tool_button("Hello", "Callable") var hello_action = hello
		
func hello():
	print("Hello")
