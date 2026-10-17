class_name BasicCombatBehavior extends Behavior





enum Phase {

	REPOSITION,

	CIRCLE,

	ATTACK,

}




@export var circle_target:= true

@export var wander_approach:= false

@export var circle_duration_range:= Vector2(1.0, 2.5)

@export var reposition_range:= Vector2(0.0, 0.0)


var movement_component: MovementComponent2

var combat_component: CombatComponent


var phase:= Phase.REPOSITION


var circle_timer:= 0.0

var circle_position_timer:= 0.2

var circle_direction:= 1





func _initialize(_actor: EntityNode) -> void:

	super(_actor)

	movement_component = actor.get_component(MovementComponent2)

	combat_component = actor.get_component(CombatComponent)

	actor.combat_melee_sensor.entity_entered.connect(_on_entity_entered_combat_melee_sensor)






func _start(_data:= {}) -> void:

	super(_data)

	_change_phase(Phase.REPOSITION)





func _update_target(new_target: EntityNode) -> void:

	super(new_target)





func _change_phase(new_phase: Phase) -> void:

	phase = new_phase

	match phase:

		Phase.REPOSITION:

			_reposition()

		Phase.CIRCLE:

			circle_timer = randf_range(circle_duration_range.x, circle_duration_range.y)

			_circle()






func _find_target() -> void:

	var new_target = actor.vision_sensor.get_nearest_enemy()

	new_target_requested.emit(new_target)




func _get_reposition_position() -> Vector2:

	var dir_from_target = actor.get_direction(target, true)

	var angle_variance = deg_to_rad(randf_range(-45.0, 45.0))

	var distance = randf_range(reposition_range.x, reposition_range.y)

	var target_position = target.global_position + (dir_from_target.rotated(angle_variance) * distance)

	return target_position



func _get_circle_position() -> Vector2:

	var dir_from_target = actor.get_direction(target, true)

	var angle = deg_to_rad(15) * circle_direction

	var distance = randf_range(reposition_range.x, reposition_range.y)

	var target_position = target.global_position + (dir_from_target.rotated(angle) * distance)

	return target_position




func _reposition() -> void:

	movement_component.navigation_position_reached.connect(_on_navigation_finished, CONNECT_ONE_SHOT)

	var target_position = _get_reposition_position()

	movement_component.set_navigation_position(target_position)





func _circle() -> void:

	pass





func _attack() -> void:

	pass






func _execute_attack() -> void:

	pass






func _on_navigation_finished() -> void:

	match phase:

		Phase.REPOSITION:

			if circle_target:

				_change_phase(Phase.CIRCLE)

			else:

				_change_phase(Phase.ATTACK)





func _on_entity_entered_combat_melee_sensor(entity_node: EntityNode) -> void:

	if entity_node == target:

		_execute_attack()





func _tick(delta: float) -> void:

	match phase:

		Phase.CIRCLE:

			var move_dir = actor.global_position.direction_to(target.global_position).rotated(deg_to_rad(90) * circle_direction)

			print("setting ", move_dir)

			movement_component.set_move_dir(move_dir)