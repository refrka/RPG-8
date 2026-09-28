class_name MovementComponent extends Component



signal move_started

signal move_ended


@export var modifier_handler: ModifierHandler


var current_velocity:= Vector2.ZERO

var move_dir:= Vector2.ZERO

var face_dir:= Vector2.RIGHT

var input_component: InputComponent

var first_input_received:= false






func _initialize(_entity: EntityNode) -> void:

	super(_entity)

	input_component = entity.get_component(InputComponent)

	if input_component:

		input_component.move_input_received.connect(_on_move_input_received)







func _activate() -> void:

	super()

	_clear()





func _clear() -> void:

	current_velocity = Vector2.ZERO

	move_dir = Vector2.ZERO

	first_input_received = false

	



func add_speed_modifier() -> void:

	pass



func add_velocity_modifier() -> void:

	pass







func get_move_dir() -> Vector2:

	if not entity is Player:

		return move_dir

	if !first_input_received:

		return Vector2.ZERO

	return input_component.input_dir
	


func get_move_speed() -> float:

	var modifier_total = modifier_handler.get_float_total()

	return 300.0 + modifier_total






func _on_move_input_received() -> void:

	first_input_received = true








func _physics_process(delta: float) -> void:

	if !active:

		return

	var move_velocity = current_velocity

	var dir = get_move_dir()

	if dir == Vector2.ZERO:

		move_velocity = move_velocity.move_toward(Vector2.ZERO, 9000.0 * delta)

	else:

		move_velocity = move_velocity.move_toward(dir * get_move_speed(), 9000.0 * delta)

	var modifier_velocity = modifier_handler.get_vector_total()

	move_velocity += modifier_velocity

	entity.velocity = move_velocity

	entity.move_and_slide()

	current_velocity = entity.velocity





