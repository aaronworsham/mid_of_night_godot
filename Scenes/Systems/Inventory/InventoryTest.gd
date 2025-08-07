class_name InventoryTest extends Node

@export var inventory_system: Node

func _ready() -> void:
    # Wait a frame to ensure everything is initialized
    await get_tree().process_frame
    
    # Run the test
    run_inventory_test()

func run_inventory_test() -> void:
    print("=== Starting Inventory System Test ===")
    
    if not inventory_system:
        print("ERROR: No inventory system assigned!")
        return
    
    # Test 1: Create and add items
    test_item_creation()
    
    # Test 2: Test inventory operations
    test_inventory_operations()
    
    # Test 3: Test sorting and filtering
    test_sorting_and_filtering()
    
    # Test 4: Test save/load functionality
    test_save_load()
    
    print("=== Inventory System Test Complete ===")

func test_item_creation() -> void:
    print("\n--- Testing Item Creation ---")
    
    # Create a custom item
    var custom_item = inventory_system.create_custom_item(
        "Test Sword",
        "A sharp blade for testing",
        "weapon",
        "rare",
        5.0,
        100,
        1,
        false
    )
    
    print("Created custom item: ", custom_item.get_item_name())
    print("Item type: ", custom_item.get_item_type())
    print("Item rarity: ", custom_item.get_rarity())
    print("Item weight: ", custom_item.get_weight())
    print("Item value: ", custom_item.get_value())
    
    # Add to inventory
    var success = inventory_system.add_item_to_inventory(custom_item)
    print("Added to inventory: ", success)
    
    # Create a stackable item
    var stackable_item = inventory_system.create_custom_item(
        "Health Potion",
        "Restores health",
        "consumable",
        "common",
        0.5,
        10,
        10,
        true
    )
    
    # Add multiple potions
    for i in range(5):
        var potion = inventory_system.create_custom_item(
            "Health Potion",
            "Restores health",
            "consumable",
            "common",
            0.5,
            10,
            10,
            true
        )
        inventory_system.add_item_to_inventory(potion)
    
    print("Added 5 health potions to inventory")

func test_inventory_operations() -> void:
    print("\n--- Testing Inventory Operations ---")
    
    # Get inventory summary
    var summary = inventory_system.get_inventory_summary()
    print("Inventory Summary:")
    print("  Total items: ", summary.total_items)
    print("  Total weight: ", summary.total_weight)
    print("  Total value: ", summary.total_value)
    print("  Slots used: ", summary.slots_used)
    print("  Slots available: ", summary.slots_available)
    
    # Test item retrieval
    var items = inventory_system.get_inventory_items()
    print("Items in inventory:")
    for item in items:
        print("  - ", item.get_item_name(), " (x", item.get_count(), ")")
    
    # Test filtering
    var weapons = inventory_system.get_items_by_type("weapon")
    print("Weapons in inventory: ", weapons.size())
    
    var rare_items = inventory_system.get_items_by_rarity("rare")
    print("Rare items in inventory: ", rare_items.size())
    
    # Test item usage
    if items.size() > 0:
        var first_item = items[0]
        print("Using item: ", first_item.get_item_name())
        inventory_system.use_item(first_item)
        print("Item used successfully")

func test_sorting_and_filtering() -> void:
    print("\n--- Testing Sorting and Filtering ---")
    
    # Add some more items for sorting
    var items_to_add = [
        {"name": "Gold Coin", "type": "currency", "rarity": "common", "weight": 0.01, "value": 1},
        {"name": "Diamond", "type": "gem", "rarity": "legendary", "weight": 0.1, "value": 1000},
        {"name": "Iron Ore", "type": "material", "rarity": "common", "weight": 2.0, "value": 5},
        {"name": "Magic Scroll", "type": "spell", "rarity": "epic", "weight": 0.2, "value": 500}
    ]
    
    for item_data in items_to_add:
        var item = inventory_system.create_custom_item(
            item_data.name,
            "A " + item_data.name,
            item_data.type,
            item_data.rarity,
            item_data.weight,
            item_data.value
        )
        inventory_system.add_item_to_inventory(item)
    
    print("Added more items for sorting test")
    
    # Test sorting by name
    print("Sorting by name...")
    inventory_system.sort_inventory_by_name()
    
    # Test sorting by value
    print("Sorting by value...")
    inventory_system.sort_inventory_by_value()
    
    # Test sorting by weight
    print("Sorting by weight...")
    inventory_system.sort_inventory_by_weight()
    
    # Test search functionality
    var search_results = inventory_system.search_items("gold")
    print("Search results for 'gold': ", search_results.size(), " items")

func test_save_load() -> void:
    print("\n--- Testing Save/Load Functionality ---")
    
    # Save current inventory
    var save_data = inventory_system.save_inventory()
    print("Saved inventory data: ", save_data.keys())
    
    # Clear inventory
    inventory_system.clear_inventory()
    print("Cleared inventory")
    
    # Load inventory back
    inventory_system.load_inventory(save_data)
    print("Loaded inventory back")
    
    # Verify items are back
    var items = inventory_system.get_inventory_items()
    print("Items after load: ", items.size())

func _input(event: InputEvent) -> void:
    if event.is_action_pressed("ui_accept"):
        # Press Enter to run test again
        run_inventory_test()
    
    if event.is_action_pressed("inventory"):
        # Press I to toggle inventory
        inventory_system.toggle_inventory()
