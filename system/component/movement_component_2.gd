class_name MovementComponent2 extends Component



signal navigation_position_reached

signal navigation_target_reached


enum MovementState {

	HALT,

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

	if entity is CharacterNode:

		entity.nav_agent.navigation_finished.connect(_on_navigation_finished)





func halt() -> void:

	_change_movement_state(MovementState.HALT)







func receive_damage_package(damage_package: DamagePackage) -> void:

	if damage_package.attack_entry.knockback_force > 0.0:

		var modifier = Modifier.new_modifier(damage_package.damage_vector * damage_package.attack_entry.knockback_force, 0.07)

		modifier_handler.add_modifier(modifier)

		



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

		MovementState.HALT:

			current_move_dir = Vector2.ZERO

			current_move_velocity = Vector2.ZERO

			entity.velocity = Vector2.ZERO

		MovementState.DIRECTION:

			pass
			
		MovementState.POSITION:

			entity.nav_agent.target_position = current_navigation_position

		MovementState.TARGET:

			pass






func _on_navigation_finished() -> void:

	navigation_position_reached.emit()



	

func _physics_process(delta: float) -> void:

	if !active:

		return

	var move_velocity = current_move_velocity

	match movement_state:

		MovementState.HALT:

			move_velocity = Vector2.ZERO

		MovementState.DIRECTION:

			if current_move_dir == Vector2.ZERO:

				move_velocity = move_velocity.move_toward(Vector2.ZERO, 8000.0 * delta)

			else:

				move_velocity = move_velocity.move_toward(current_move_dir * get_move_speed(), 8000.0 * delta)

		MovementState.TARGET:

			pass

		MovementState.POSITION:

			if entity.nav_agent.is_navigation_finished():

				move_velocity = move_velocity.move_toward(Vector2.ZERO, 8000.0 * delta)

			else:

				var next_position = entity.nav_agent.get_next_path_position()

				var path_dir = entity.global_position.direction_to(next_position)

				move_velocity = move_velocity.move_toward(path_dir * get_move_speed(), 8000.0 * delta)

	entity.velocity = move_velocity + modifier_handler.get_vector_total()

	current_move_velocity = move_velocity

	entity.move_and_slide()

