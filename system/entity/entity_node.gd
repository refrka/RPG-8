class_name EntityNode extends PhysicsBody2D





@export_group("Node Exports")

@export var component_root: Node

@export var state_machine: StateMachine




var initialized:= false

var active:= false







func _initialize() -> bool:

	if initialized:

		return false

	initialized = true

	for component in component_root.get_children():

		component._initialize(self)

	state_machine._initialize(self)

	return true





func _activate() -> void:

	_connect_signals()

	active = true

	for component in component_root.get_children():

		component._activate()

	state_machine._activate()




func _deactivate() -> void:

	active = false

	for component in component_root.get_children():

		component._deactivate()

	state_machine._deactivate()

	_disconnect_signals()





func _connect_signals() -> void:

	pass



func _disconnect_signals() -> void:

	pass












func get_component(component_script: Script) -> Component:

	for component in component_root.get_children():

		if component.get_component_script() == component_script:

			return component

	return null