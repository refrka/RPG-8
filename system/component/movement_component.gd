class_name MovementComponent extends Component




signal navigation_position_reached

signal move_started

signal move_ended

signal face_dir_updated


enum MovementState {

	HALT,

	DIRECTION,

	POSITION,

	TARGET,

}

@export var target_position_time:= 0.2

var modifier_handler: ModifierHandler

var movement_state: MovementState

var face_dir:= Vector2.RIGHT

var current_move_dir:= Vector2.ZERO

var current_move_velocity:= Vector2.ZERO

var current_navigation_position: Vector2

var current_navigation_target: EntityNode

var move_speed_override:= -1.0

var target_position_timer:= 0.0





func _initialize(_entity: EntityNode) -> void:

	super(_entity)

	modifier_handler = ModifierHandler.new()

	add_child(modifier_handler)

	if entity is CharacterNode:

		entity.nav_agent.navigation_finished.connect(_on_navigation_finished)

		if not entity is Player:

			entity.nav_agent.velocity_computed.connect(_on_velocity_computed)

	var input_component = entity.get_component(InputComponent)

	if input_component:

		input_component.dodge_pressed.connect(_on_dodge_input_pressed)

	var dodging_state = entity.state_machine.get_state(BodyDodgingState)

	if dodging_state:

		dodging_state.dodge_complete.connect(_on_dodge_complete)




func _deactivate() -> void:

	halt()
	
	super()







func halt() -> void:

	entity.velocity = Vector2.ZERO

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

	if move_speed_override >= 0.0:

		return move_speed_override

	return (entity.entity_def.move_speed + modifier_handler.get_float_total()) * modifier_handler.get_multiplier_total()









func is_navigation_position_valid() -> bool:

	return entity.nav_agent.is_target_reachable()






func _change_movement_state(new_state: MovementState) -> void:

	movement_state = new_state

	match movement_state:

		MovementState.HALT:

			set_navigation_target(null)

			entity.velocity = Vector2.ZERO

			current_move_dir = Vector2.ZERO

			current_move_velocity = Vector2.ZERO
			
		MovementState.POSITION:

			entity.nav_agent.target_position = current_navigation_position

		MovementState.TARGET:

			entity.nav_agent.target_position = current_navigation_target.global_position

			target_position_timer = target_position_time






func _on_navigation_finished() -> void:

	navigation_position_reached.emit()



func _on_velocity_computed(velocity: Vector2) -> void:

	if !active:

		entity.velocity = Vector2.ZERO

		return

	entity.velocity = velocity + modifier_handler.get_vector_total()

	current_move_velocity = velocity

	entity.move_and_slide()


	

func _physics_process(delta: float) -> void:

	if !active:

		return

	var move_velocity = current_move_velocity

	var move_speed = get_move_speed()

	match movement_state:

		MovementState.HALT:

			move_velocity = Vector2.ZERO

		MovementState.DIRECTION:

			if current_move_dir == Vector2.ZERO:

				move_velocity = move_velocity.move_toward(Vector2.ZERO, 8000.0 * delta)

			else:

				move_velocity = move_velocity.move_toward(current_move_dir * move_speed, 8000.0 * delta)

		MovementState.TARGET:

			if !is_instance_valid(current_navigation_target):

				_change_movement_state(MovementState.HALT)

				return

			target_position_timer -= delta

			if target_position_timer <= 0.0:

				entity.nav_agent.target_position = current_navigation_target.global_position

				target_position_timer = target_position_time

			if entity.nav_agent.is_navigation_finished():

				move_velocity = move_velocity.move_toward(Vector2.ZERO, 8000.0 * delta)

			else:

				var next_position = entity.nav_agent.get_next_path_position()

				var path_dir = entity.global_position.direction_to(next_position)

				move_velocity = move_velocity.move_toward(path_dir * move_speed, 8000.0 * delta)

		MovementState.POSITION:

			if entity.nav_agent.is_navigation_finished():

				move_velocity = move_velocity.move_toward(Vector2.ZERO, 8000.0 * delta)

			else:

				var next_position = entity.nav_agent.get_next_path_position()

				var path_dir = entity.global_position.direction_to(next_position)

				move_velocity = move_velocity.move_toward(path_dir * move_speed, 8000.0 * delta)

	var final_velocity = move_velocity + modifier_handler.get_vector_total()

	if entity.velocity == Vector2.ZERO and final_velocity != Vector2.ZERO:

		move_started.emit()

	if entity.velocity != Vector2.ZERO and final_velocity == Vector2.ZERO:

		move_ended.emit()

	if (entity is CharacterNode and not entity is Player) and entity.nav_agent.avoidance_enabled:

		entity.nav_agent.set_velocity(move_velocity)

	else:

		_on_velocity_computed(move_velocity)

	if move_velocity != Vector2.ZERO:

		face_dir = move_velocity.normalized()

		face_dir_updated.emit()






func _on_dodge_input_pressed() -> void:

	entity.state_machine.request_state(BodyDodgingState)



func _on_dodge_complete() -> void:

	entity.state_machine.request_state(BodyIdleState)