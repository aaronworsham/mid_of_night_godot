extends GutTest

class TestDetectiveManager:
	extends GutTest
	var _dm = null

	func before_each():
		_dm = DetectiveManager.new()
	

	func test_strength():
		assert_eq(_dm.get_strength(),5)
