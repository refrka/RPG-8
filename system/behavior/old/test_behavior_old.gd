class_name TestBehavior extends BehaviorOld



enum Phase {

	REPOSITION,

	APPROACH,

	CIRCLE,

	INTIMIDATE,

	ATTACK,
	
}



@export var distance_range:= Vector2.ZERO


var target_entity: EntityNode

var navigation_component: NavigationComponent

var movement_component: MovementComponent

var combat_component: CombatComponent

var phase:= Phase.REPOSITION

var dir_modifier:= 1

var circle_duration_range:= Vector2(3.0, 5.0)

var circle_timer:= 0.0

var intimidate_timer:= 0.0

var attack_timer:= 0.0



func _initialize(_actor: EntityNode) -> void:
	
	super(_actor)

	navigation_component = actor.get_component(NavigationComponent)

	movement_component = actor.get_component(MovementComponent)

	combat_component = actor.get_component(CombatComponent)

	combat_component.attack_completed.connect(_on_attack_completed)





func _connect_signals() -> void:

	actor.vision_sensor.entity_entered.connect(_on_entity_entered_sensor)





func _get_follow_distance() -> float:

	return randf_range(distance_range.x, distance_range.y)





func _set_phase(_phase: Phase) -> void:

	phase = _phase

	movement_component.move_speed_override = 0.0

	match phase:

		Phase.REPOSITION:

			var follow_distance = _get_follow_distance()

			var dir = target_entity.global_position.direction_to(actor.global_position)

			var position = target_entity.global_position + (dir * follow_distance)

			navigation_component.navigation_finished.connect(_on_reposition_finished, CONNECT_ONE_SHOT)

			navigation_component.set_target_position(position)

		Phase.CIRCLE:

			circle_timer = randf_range(circle_duration_range.x, circle_duration_range.y)

			movement_component.move_speed_override = 50.0

		Phase.APPROACH:

			navigation_component.navigation_finished.connect(_on_approach_finished, CONNECT_ONE_SHOT)

			navigation_component.set_target_position(target_entity.global_position)

		Phase.INTIMIDATE:

			intimidate_timer = 2.0

		Phase.ATTACK:

			combat_component._try_attack()





func _set_target_entity(entity: EntityNode) -> void:

	if target_entity == entity:

		return

	target_entity = entity

	target_entity.died.connect(_on_target_died)

	_set_phase(Phase.REPOSITION)




func _on_entity_entered_sensor(entity: EntityNode) -> void:

	if entity is Player:

		_set_target_entity(entity)




func _on_reposition_finished() -> void:

	_set_phase(Phase.CIRCLE)



func _on_approach_finished() -> void:

	_set_phase(Phase.ATTACK)



func _on_attack_completed() -> void:

	_set_phase(Phase.REPOSITION)



func _on_target_died() -> void:

	behavior_state_requested.emit(BehaviorComponent.BehaviorState.PASSIVE)

	target_entity = null
	




func _tick(delta: float) -> void:

	if !target_entity:

		return

	match phase:

		Phase.CIRCLE:

			var dir = actor.global_position.direction_to(target_entity.global_position).rotated(deg_to_rad(90)) * dir_modifier

			var position = actor.global_position + (dir * 16)

			navigation_component.set_target_position(position)

			if !actor.nav_agent.is_target_reachable():

				dir_modifier *= -1

			circle_timer -= delta

			if circle_timer <= 0.0:

				_set_phase(Phase.INTIMIDATE)

		Phase.APPROACH:

			if !is_instance_valid(navigation_component):

				return

		Phase.INTIMIDATE:

			intimidate_timer -= delta

			if intimidate_timer <= 0.0:

				_set_phase(Phase.APPROACH)