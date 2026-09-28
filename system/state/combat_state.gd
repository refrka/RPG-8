class_name CombatState extends State





var combat_component: CombatComponent

var animation_component: AnimationComponent







func _initialize(_entity: EntityNode) -> void:

	super(_entity)

	combat_component = entity.get_component(CombatComponent)

	animation_component = entity.get_component(AnimationComponent)