class_name StateMachine extends Node






@export_group("Node Exports")

@export var body_root: Node

@export var combat_root: Node

@export var initial_body_state: BodyState

@export var initial_combat_state: CombatState


var active:= false

var current_body_state: BodyState

var current_combat_state: CombatState








func _initialize(entity: EntityNode) -> void:

	var states = []

	if body_root:

		states += body_root.get_children()

	if combat_root:

		states += combat_root.get_children()

	for state in states:

		state._initialize(entity)

		state.transition_requested.connect(_on_transition_requested)




func _activate() -> void:

	pass




func _deactivate() -> void:

	pass





func _change_state(new_state: State) -> void:

	if new_state is BodyState and body_root:

		_change_body_state(new_state)

	elif new_state is CombatState and combat_root:

		_change_combat_state(new_state)




func _change_body_state(new_state: State) -> void:

	if current_body_state:

		if current_body_state == new_state and current_body_state.allow_reenter:

			current_body_state._enter()
		
		else:

			current_body_state._exit()

	current_body_state = new_state

	current_body_state._enter()




func _change_combat_state(new_state: State) -> void:

	if current_combat_state:

		if current_combat_state == new_state and current_combat_state.allow_reenter:

			current_combat_state._enter()
		
		else:

			current_combat_state._exit()

	current_combat_state = new_state

	current_combat_state._enter()






func request_state(state_script: Script) -> void:

	var state = get_state(state_script)

	if state:

		_change_state(state)





func get_state(state_script: Script) -> State:

	for state in body_root.get_children() + combat_root.get_children():

		if state.get_state_script() == state_script:

			return state

	return null










func _on_transition_requested(state_script: Script) -> void:
	
	request_state(state_script)