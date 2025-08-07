# Godot 4.0 Inventory System

A comprehensive, modular inventory system for Godot 4.0 with support for item stacking, weight limits, rarity systems, and more.

## Features

- **Item Stacking**: Automatic stacking of identical items with configurable stack limits
- **Weight System**: Configurable weight limits with visual feedback
- **Slot Management**: Limited inventory slots with overflow protection
- **Rarity System**: Color-coded items by rarity (common, uncommon, rare, epic, legendary)
- **Item Types**: Categorization system for filtering and organization
- **Save/Load**: Complete inventory persistence
- **Sorting**: Multiple sorting options (name, value, weight)
- **Search**: Text-based item search functionality
- **Modern UI**: Grid-based layout with tooltips and context menus
- **Signal System**: Comprehensive event system for integration

## Architecture

### Core Components

1. **ItemResource** (`ItemResource.gd`)
   - Represents individual items with properties like name, description, weight, value, etc.
   - Handles item stacking logic
   - Provides rarity color coding
   - Supports serialization for save/load

2. **InventoryController** (`InventoryController.gd`)
   - Manages the actual inventory data
   - Handles adding/removing items with stacking logic
   - Enforces weight and slot limits
   - Provides sorting and filtering methods
   - Emits signals for inventory changes

3. **InventoryView** (`InventoryView.gd`)
   - Handles the UI display of the inventory
   - Manages item selection and interaction
   - Updates visual elements (weight bar, slot count, etc.)
   - Provides item details panel

4. **ItemsResource** (`ItemsResource.gd`)
   - Manages the item database/templates
   - Loads items from JSON files
   - Provides item creation and search functionality
   - Handles item type and rarity categorization

5. **InventorySystem** (`InventorySystem.gd`)
   - High-level coordinator that ties everything together
   - Provides a clean API for other systems
   - Handles input for opening/closing inventory
   - Manages save/load operations

6. **ItemSlot** (`ItemSlot.gd`)
   - Individual slot component for displaying items
   - Handles mouse interactions and tooltips
   - Provides context menu functionality

## Usage

### Basic Setup

1. **Add the InventorySystem to your scene:**
```gdscript
# In your main scene or game manager
var inventory_system: InventorySystem

func _ready():
    inventory_system = InventorySystem.new()
    add_child(inventory_system)
```

2. **Configure the system:**
```gdscript
# Set limits
inventory_system.max_weight = 100.0
inventory_system.max_slots = 50
```

3. **Connect to signals:**
```gdscript
inventory_system.item_added_to_inventory.connect(_on_item_added)
inventory_system.item_used.connect(_on_item_used)
inventory_system.inventory_opened.connect(_on_inventory_opened)
```

### Adding Items

```gdscript
# Create a custom item
var sword = inventory_system.create_custom_item(
    "Iron Sword",
    "A basic iron sword",
    "weapon",
    "common",
    5.0,  # weight
    50,   # value
    1,    # max stack
    false # not stackable
)

# Add to inventory
var success = inventory_system.add_item_to_inventory(sword)
if success:
    print("Sword added successfully!")
else:
    print("Could not add sword - inventory full or overweight")
```

### Creating Items from Templates

```gdscript
# If you have items defined in your JSON data
var potion = inventory_system.create_item_from_template("Health Potion")
if potion:
    inventory_system.add_item_to_inventory(potion)
```

### Inventory Operations

```gdscript
# Check if player has an item
if inventory_system.has_item(sword):
    print("Player has the sword!")

# Use an item
inventory_system.use_item(potion)

# Remove items
inventory_system.remove_item_from_inventory(sword, 1)

# Get inventory info
var summary = inventory_system.get_inventory_summary()
print("Total weight: ", summary.total_weight)
print("Total value: ", summary.total_value)
```

### Sorting and Filtering

```gdscript
# Sort inventory
inventory_system.sort_inventory_by_name()
inventory_system.sort_inventory_by_value()
inventory_system.sort_inventory_by_weight()

# Filter items
var weapons = inventory_system.get_items_by_type("weapon")
var rare_items = inventory_system.get_items_by_rarity("rare")

# Search items
var search_results = inventory_system.search_items("sword")
```

### Save/Load System

```gdscript
# Save inventory
var save_data = inventory_system.save_inventory()

# Load inventory
inventory_system.load_inventory(save_data)
```

### UI Integration

```gdscript
# Open/close inventory
inventory_system.open_inventory()
inventory_system.close_inventory()
inventory_system.toggle_inventory()

# Check if inventory is open
if inventory_system.is_inventory_open:
    print("Inventory is currently open")
```

## Item Properties

### Required Properties
- `name`: Item display name
- `description`: Item description
- `type`: Item category (weapon, armor, consumable, etc.)
- `rarity`: Item rarity (common, uncommon, rare, epic, legendary)
- `weight`: Item weight in arbitrary units
- `value`: Item monetary value
- `max_stack`: Maximum items per stack
- `stackable`: Whether items can stack

### Rarity Colors
- **Common**: White
- **Uncommon**: Green
- **Rare**: Blue
- **Epic**: Purple
- **Legendary**: Orange

## Input Actions

The system expects these input actions to be defined in your project settings:

- `inventory`: Toggle inventory open/close (default: I key)
- `ui_cancel`: Close inventory (default: Escape key)

## JSON Data Structure

The system loads items from JSON files with this structure:

```json
{
  "data": [
    {
      "id": 1,
      "name": "Iron Sword",
      "description": "A basic iron sword",
      "type": "weapon",
      "rarity": "common",
      "weight": 5.0,
      "value": 50,
      "max_stack": 1,
      "stackable": false
    }
  ]
}
```

## Signals

### InventoryController Signals
- `item_added(item)`: Emitted when an item is successfully added
- `item_removed(item)`: Emitted when an item is removed
- `item_used(item)`: Emitted when an item is used
- `inventory_changed()`: Emitted when inventory contents change
- `weight_changed(current_weight, max_weight)`: Emitted when weight changes

### InventorySystem Signals
- `inventory_opened()`: Emitted when inventory is opened
- `inventory_closed()`: Emitted when inventory is closed
- `item_added_to_inventory(item, success)`: Emitted when attempting to add an item
- `item_removed_from_inventory(item)`: Emitted when an item is removed
- `item_used(item)`: Emitted when an item is used

### InventoryView Signals
- `item_selected(item)`: Emitted when an item is selected
- `item_used(item)`: Emitted when an item is used via UI
- `item_dropped(item)`: Emitted when an item is dropped via UI

## Customization

### Adding New Item Types
1. Add the new type to your JSON data
2. The system will automatically recognize new types
3. Use `get_items_by_type("your_type")` to filter

### Adding New Rarities
1. Add the new rarity to your JSON data
2. Update the `get_rarity_color()` method in `ItemResource.gd`
3. Use `get_items_by_rarity("your_rarity")` to filter

### Custom UI Themes
The system uses standard Godot UI components and can be themed using:
- Custom themes for panels, buttons, and labels
- Custom fonts and colors
- Custom item slot layouts

## Performance Considerations

- The system uses efficient data structures for lookups
- Item stacking reduces memory usage
- Grid-based UI scales well with large inventories
- Save/load operations are optimized for minimal data transfer

## Troubleshooting

### Common Issues

1. **Items not stacking**: Check that `stackable` is true and items have the same GUID
2. **Weight limit exceeded**: Increase `max_weight` or reduce item weights
3. **Slot limit exceeded**: Increase `max_slots` or remove items
4. **UI not updating**: Ensure signals are properly connected
5. **Save/load not working**: Check that save data structure matches expected format

### Debug Information

Enable debug output by checking the console for:
- Item addition/removal messages
- Weight and slot usage
- Save/load operations
- Error messages for missing files or invalid data

## Example Integration

See `InventoryTest.gd` for a complete example of how to use all features of the inventory system.

## License

This inventory system is part of the Mid of Night Godot project and follows the same licensing terms.
