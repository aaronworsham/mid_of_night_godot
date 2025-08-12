class_name MysteryModelTest extends MysteryModel

func _init() -> void:
	mystery_name = "Mystery Test"
	mystery_description = "This is a test mystery"
	mystery_clues = ["Clue 1", "Clue 2", "Clue 3"]
	mystery_solutions = ["Solution 1", "Solution 2", "Solution 3"]
	mystery_status = "In Progress"
	mystery_progress = 0
	mystery_rewards = ["Reward 1", "Reward 2", "Reward 3"]
	mystery_unlocked = false