class_name MovementComponent2 extends Component




enum MovementState {

	DIRECTION,

	POSITION,

	TARGET,

}

var modifier_handler: ModifierHandler

var movement_state: MovementState

var face_dir:= Vector2.RIGHT

var current_move_dir:= Vector2.ZERO

var current_move_velocity:= Vector2.ZERO

var current_navigation_position: Vector2

var current_navigation_target: EntityNode

var move_speed_override:= -1.0

var desired_move_velocity:= Vector2.ZERO






func _initialize(_entity: EntityNode) -> void:

	super(_entity)

	modifier_handler = ModifierHandler.new()

	add_child(modifier_handler)





func set_navigation_position(position: Vector2) -> void:

	current_navigation_position = position

	_change_movement_state(MovementState.POSITION)




func set_navigation_target(target: EntityNode) -> void:

	current_navigation_target = target

	if is_instance_valid(target):

		_change_movement_state(MovementState.TARGET)




func set_move_dir(dir: Vector2) -> void:

	current_move_dir = dir

	_change_movement_state(MovementState.DIRECTION)




func set_move_speed_override(speed: float) -> void:

	move_speed_override = speed




func get_move_speed() -> float:

	if move_speed_override > 0.0:

		return move_speed_override

	return entity.entity_def.move_speed * modifier_handler.get_float_total()









func is_navigation_position_valid() -> bool:

	return entity.nav_agent.is_target_reachable()




func _change_movement_state(new_state: MovementState) -> void:

	if movement_state == new_state:

		return

	movement_state = new_state

	match movement_state:

		MovementState.DIRECTION:

			pass
			
		MovementState.POSITION:

			pass

		MovementState.TARGET:

			pass





	

func _physics_process(delta: float) -> void:

	if !active:

		return

	var move_velocity = current_move_velocity

	match movement_state:

		MovementState.DIRECTION:

			pass

		MovementState.TARGET:

			pass

		MovementState.POSITION:

			pass

	entity.velocity = desired_move_velocity

	current_move_velocity = entity.velocity

