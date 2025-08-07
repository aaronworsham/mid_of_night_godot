class_name OvertabModel extends Resource

signal overtab_changed(property_name: String, old_value, new_value)

var overtab_name: String:
    set(value):
        var old_value = overtab_name
        overtab_name = value
        overtab_changed.emit("overtab_name", old_value, value)

var overtab_description: String:
    set(value):
        var old_value = overtab_description
        overtab_description = value
        overtab_changed.emit("overtab_description", old_value, value)

var overtab_icon: String:
    set(value):
        var old_value = overtab_icon
        overtab_icon = value
        overtab_changed.emit("overtab_icon", old_value, value)

var overtab_color: String:
    set(value):
        var old_value = overtab_color
        overtab_color = value
        overtab_changed.emit("overtab_color", old_value, value)

var overtab_size: Vector2:
    set(value):
        var old_value = overtab_size
        # Ensure minimum size
        overtab_size = Vector2(max(value.x, 10.0), max(value.y, 10.0))
        overtab_changed.emit("overtab_size", old_value, overtab_size)

var overtab_position: Vector2:
    set(value):
        var old_value = overtab_position
        overtab_position = value
        overtab_changed.emit("overtab_position", old_value, value)

var overtab_rotation: float:
    set(value):
        var old_value = overtab_rotation
        # Normalize rotation to 0-360 degrees
        overtab_rotation = fmod(value, 360.0)
        if overtab_rotation < 0:
            overtab_rotation += 360.0
        overtab_changed.emit("overtab_rotation", old_value, overtab_rotation)

# Constructor function for easy initialization
func _init(name: String = "", description: String = "", icon: String = "", 
           color: String = "#ffffff", size: Vector2 = Vector2(100, 100), 
           position: Vector2 = Vector2.ZERO, rotation: float = 0.0) -> void:
    overtab_name = name
    overtab_description = description
    overtab_icon = icon
    overtab_color = color
    overtab_size = size
    overtab_position = position
    overtab_rotation = rotation

# Utility functions for common operations
func set_overtab_name(name: String) -> void:
    overtab_name = name

func set_overtab_description(description: String) -> void:
    overtab_description = description

func set_overtab_icon(icon: String) -> void:
    overtab_icon = icon

func set_overtab_color(color: String) -> void:
    overtab_color = color

func set_overtab_size(size: Vector2) -> void:
    overtab_size = size

func set_overtab_position(position: Vector2) -> void:
    overtab_position = position

func set_overtab_rotation(rotation: float) -> void:
    overtab_rotation = rotation

# Batch update function to update multiple properties at once
func update_properties(name: String = "", description: String = "", icon: String = "", 
                      color: String = "", size: Vector2 = Vector2.ZERO, 
                      position: Vector2 = Vector2.ZERO, rotation: float = -1.0) -> void:
    if name != "":
        overtab_name = name
    if description != "":
        overtab_description = description
    if icon != "":
        overtab_icon = icon
    if color != "":
        overtab_color = color
    if size != Vector2.ZERO:
        overtab_size = size
    if position != Vector2.ZERO:
        overtab_position = position
    if rotation != -1.0:
        overtab_rotation = rotation

# Getter functions for consistency
func get_overtab_name() -> String:
    return overtab_name

func get_overtab_description() -> String:
    return overtab_description

func get_overtab_icon() -> String:
    return overtab_icon

func get_overtab_color() -> String:
    return overtab_color

func get_overtab_size() -> Vector2:
    return overtab_size

func get_overtab_position() -> Vector2:
    return overtab_position

func get_overtab_rotation() -> float:
    return overtab_rotation

# Utility functions for data conversion
func to_dict() -> Dictionary:
    return {
        "name": overtab_name,
        "description": overtab_description,
        "icon": overtab_icon,
        "color": overtab_color,
        "size": {"x": overtab_size.x, "y": overtab_size.y},
        "position": {"x": overtab_position.x, "y": overtab_position.y},
        "rotation": overtab_rotation
    }

func from_dict(data: Dictionary) -> void:
    if data.has("name"):
        overtab_name = data.name
    if data.has("description"):
        overtab_description = data.description
    if data.has("icon"):
        overtab_icon = data.icon
    if data.has("color"):
        overtab_color = data.color
    if data.has("size"):
        overtab_size = Vector2(data.size.x, data.size.y)
    if data.has("position"):
        overtab_position = Vector2(data.position.x, data.position.y)
    if data.has("rotation"):
        overtab_rotation = data.rotation

# Validation functions
func is_valid() -> bool:
    return overtab_name != "" and overtab_size.x > 0 and overtab_size.y > 0

func get_validation_errors() -> Array[String]:
    var errors: Array[String] = []
    
    if overtab_name == "":
        errors.append("Overtab name cannot be empty")
    
    if overtab_size.x <= 0 or overtab_size.y <= 0:
        errors.append("Overtab size must be greater than zero")
    
    return errors