class_name OvertabModelTest extends OvertabModel

func _init() -> void:
	# Call parent constructor with test values
	super("Overtab Test", "This is a test overtab", "res://Assets/Icons/overtab.png", 
		  "#ff0000", Vector2(100, 100), Vector2(100, 100), 0.0)
	
	# Connect to the change signal for testing
	overtab_changed.connect(_on_test_overtab_changed)

func _on_test_overtab_changed(property_name: String, old_value, new_value) -> void:
	print("Test Overtab - Property '", property_name, "' changed from ", old_value, " to ", new_value)

# Test function to demonstrate the setter methods
func run_setter_tests() -> void:
	print("=== Running OvertabModel Setter Tests ===")
	
	# Test individual setters
	set_overtab_name("Updated Test Name")
	set_overtab_description("Updated test description")
	set_overtab_icon("res://Assets/Icons/updated_overtab.png")
	set_overtab_color("#00ff00")
	set_overtab_size(Vector2(200, 150))
	set_overtab_position(Vector2(200, 200))
	set_overtab_rotation(45.0)
	
	# Test batch update
	update_properties(
		"Batch Updated Tab",
		"Updated via batch operation",
		"",
		"",
		Vector2(300, 200),
		Vector2.ZERO,
		90.0
	)
	
	# Test validation
	print("Is valid: ", is_valid())
	var errors = get_validation_errors()
	if errors.size() > 0:
		print("Validation errors:")
		for error in errors:
			print("  - ", error)
	
	# Test data conversion
	var data = to_dict()
	print("Dictionary representation: ", data)
	
	print("=== OvertabModel Setter Tests Complete ===")
