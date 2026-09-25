class_name InputComponent extends Component


signal move_input_received

signal attack_pressed

signal attack_released


var input_dir: Vector2

var first_move_input_received:= false






func _activate() -> void:

	super()

	_clear()




func _clear() -> void:

	first_move_input_received = false





func _unhandled_input(event: InputEvent) -> void:

	if event.is_action_pressed("move_left") or \

		event.is_action_pressed("move_right") or \

		event.is_action_pressed("move_up") or \

		event.is_action_pressed("move_down"):

			if !first_move_input_received:

				first_move_input_received = true

				move_input_received.emit()

	if event.is_action_pressed("attack"):

		attack_pressed.emit()

	if event.is_action_released("attack"):

		attack_released.emit()







func _process(_delta: float) -> void:

	if !active:

		return

	input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")