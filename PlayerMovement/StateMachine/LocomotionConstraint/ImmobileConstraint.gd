class_name ImmobileLocomotionBehaviour extends ILocomotionConstraint

func filter_player_input(input: PlayerInput):
	filtered_input = input
	filtered_input.locomotion_actions.erase("sprint")
