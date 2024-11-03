extends GutTest

class TestDiceManager:
	extends GutTest

	var _dm : DiceManager = null

	func before_each():
		_dm = DiceManager.new()

	func test_roll_100():
		var roll:int = _dm.roll_d100()
		assert_between(roll,1,100)

	func test_set_roll():
		_dm.set_result(10)
		var roll:int = _dm.roll_d100()
		assert_eq(roll,10)
		var roll2:int = _dm.roll_d100()
		assert_between(roll2,1,100)
