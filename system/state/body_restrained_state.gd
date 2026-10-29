class_name BodyRestrainedState extends BodyState


signal restraint_broken


var movement_component: MovementComponent


var struggle_score:= 0.0




func _initialize(_entity: EntityNode) -> void:

	super(_entity)

	movement_component = entity.get_component(MovementComponent)




func _enter() -> void:

	super()

	struggle_score = 0.0

	movement_component.halt()

	movement_component._deactivate()

	movement_component.disabled = true





func _exit() -> void:

	super()

	movement_component.disabled = false

	movement_component._activate()





func _struggle() -> void:

	struggle_score += 0.33

	if struggle_score >= 1.0:

		_break_restraint()




func _break_restraint() -> void:

	restraint_broken.emit()






func _unhandled_input(event: InputEvent) -> void:

	if !active:

		return

	if event.is_action_pressed("struggle"):

		_struggle()





func _tick(delta: float) -> void:

	if struggle_score > 0.0:

		struggle_score -= delta