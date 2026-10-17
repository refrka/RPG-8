class_name BasicAttackBehavior extends Behavior




@export var navigation_delay:= 1.5

var delay_timer: SceneTreeTimer

var combat_component: CombatComponent

var movement_component: MovementComponent2



func _initialize(_actor: EntityNode) -> void:

	super(_actor)

	combat_component = actor.get_component(CombatComponent)

	combat_component.attack_completed.connect(_on_attack_completed)

	movement_component = actor.get_component(MovementComponent2)

	movement_component.navigation_position_reached.connect(_on_target_reached)

	actor.combat_melee_sensor.entity_entered.connect(_on_entity_entered_melee_sensor)









func _start(_data:= {}) -> void:

	super(_data)

	movement_component.set_navigation_target(target)










func _on_entity_entered_melee_sensor(entity_node: EntityNode) -> void:

	if delay_timer:

		return

	if entity_node == target:

		movement_component.halt()

		combat_component._try_attack()





func _on_attack_completed() -> void:

	if is_instance_valid(target) and !delay_timer:

		delay_timer = Game.get_timer(navigation_delay)

		delay_timer.timeout.connect(_on_delay_timer_timeout)





func _on_target_reached() -> void:

	if !delay_timer:

		movement_component.halt()

		combat_component._try_attack()



func _on_delay_timer_timeout() -> void:

	delay_timer = null

	movement_component.set_navigation_target(target)

