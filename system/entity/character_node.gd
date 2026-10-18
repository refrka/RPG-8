class_name CharacterNode extends EntityNode



@export var nav_agent: NavigationAgent2D

@export var health_bar: HealthProgressBar

@export var anchor: Anchor






func _initialize() -> bool:

	if !super():

		return false

	if anchor:

		anchor.anchor_entity(self)
		
	return true



func consume(consumable_def: ConsumableDef) -> void:

	var effects_component = get_component(EffectsComponent)

	if !effects_component:

		return

	for effect in consumable_def.effects_on_consume:

		effects_component.add_effect(effect)

