class_name EffectsComponent extends Component



var active_effects: Array[Effect]



func add_effect(effect: Effect) -> void:

	effect = effect.duplicate(true)

	effect._initialize(entity)

	if not effect is InstantEffect:

		active_effects.append(effect)

		if effect is TickEffect:

			effect.ticked.connect(_on_effect_ticked.bind(effect))

		effect.expired.connect(_on_effect_expired.bind(effect))

	effect._apply()




func remove_effect(effect: Effect) -> void:

	if active_effects.has(effect):

		effect._remove()

		active_effects.erase(effect)





func _on_effect_ticked(effect: TickEffect) -> void:

	effect._apply()




func _on_effect_expired(effect: Effect) -> void:

	remove_effect(effect)





func _process(delta: float) -> void:

	if !active or disabled:

		return

	for effect in active_effects:

		effect._tick(delta)

		if effect.is_expired():

			effect._expire()
