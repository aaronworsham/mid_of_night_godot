extends GutTest

class TestMysteries:
	extends GutTest	

	var mysteries:MysteryResource = load("res://Resources/CaseFiles/Mysteries/Mystery1.tres")
	var local_json:JSON = load("res://Tests/Unit/mysteries_test_data.json")
	var m_key:String

	func before_all():
		mysteries.set_json(local_json)

	func before_each():
		m_key = mysteries.get_mysteries().keys()[0]
		pass
	
	func after_all():
		pass
	
	
	func test_setup():
		assert_not_null(mysteries)
	
	func test_mysteries_data():
		assert_not_null(mysteries.get_mysteries())
		pass

	func test_description():
		assert_eq(mysteries.get_description(m_key), "Test Mystery 1 desc")

	func test_clues():
		var clues:Dictionary = mysteries.get_clues(m_key)
		var c_key = clues.keys()[0]
		assert_eq(clues.size(), 1)
		assert_eq(c_key, "Test Clue 1")
		assert_eq(mysteries.get_clue_name(m_key, c_key), "Test Clue 1")

	func test_mystery_discovery():
		assert_false(mysteries.is_mystery_discovered(m_key))
		mysteries.set_mystery_as_discovered(m_key)
		assert_true(mysteries.is_mystery_discovered(m_key))


	
