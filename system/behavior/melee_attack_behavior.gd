class_name MeleeAttackBehavior extends Behavior






func _start(_target: EntityNode = null) -> void:

	super(_target)

	movement_component.set_navigation_target(target)