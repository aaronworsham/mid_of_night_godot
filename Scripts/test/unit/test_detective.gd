extends GutTest

class TestAttributes:
	extends GutTest
	
	var _detective = null
	var att = DetectiveModel.AttributeNames

	func before_each():
		_detective = DetectiveModel.new()
	

	func test_strength():
		assert_eq(_detective.get_att(att.STRENGTH), 5)

	func test_set_strenght():
		_detective.set_att(att.STRENGTH,6)
		assert_eq(_detective.get_att(att.STRENGTH), 6)
