class_name TestInventorySystem extends GutTest

func test_item_resource():
    var ir:ItemResource = ItemResource.new()
    ir.on_load()
    assert_eq(ir.get_item_name(), "")
    ir.set_item_name("Test")
    assert_eq(ir.get_item_name(), "Test")
    assert_eq(ir.get_count(), 0)
    ir.set_count(1)
    assert_eq(ir.get_count(), 1)
    ir.increment_count()
    assert_eq(ir.get_count(), 2)
    ir.decrement_count()
    assert_eq(ir.get_count(), 1)
    assert_not_null(ir.get_guid())
    assert_not_same(ir.get_guid(), "")

func test_items_resource():
    var ir:ItemsResource = ItemsResource.new()
    ir.on_load()
    assert_gt(ir.get_items().size(), 0)
    assert_gt(ir.get_items_as_resources().size(), 0)

func test_items_controller():
    var ic:InventoryController = InventoryController.new()
    ic.on_load()
    assert_gt(ic.get_items().size(), 0)
    assert_eq(ic.get_inventory().size(), 0)
    var ir:ItemResource = ItemResource.new()
    ic.add_to_inventory(ir)
    assert_eq(ic.get_inventory().size(), 1)
