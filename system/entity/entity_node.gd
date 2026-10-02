class_name EntityNode extends PhysicsBody2D





@export var entity_def: EntityDef

@export var inventory: Inventory


@export_group("Node Exports")

@export var component_root: Node

@export var state_machine: StateMachine

@export var animated_body_sprite: AnimatedSprite2D

@export var body_sprite: Sprite2D

@export var combat_root: Node2D

@export var hitbox: Hitbox

@export var hurtbox: Hurtbox

@export var pick_up_area: Area2D





var initialized:= false

var active:= false







func _initialize() -> bool:

	if initialized:

		return false

	initialized = true

	if hitbox:

		hitbox._initialize(self)

	if hurtbox:
		
		hurtbox._initialize(self)

	if entity_def.initial_inventory:

		inventory = entity_def.initial_inventory.duplicate(true)

	if inventory:

		inventory._initialize()

	if component_root:

		for component in component_root.get_children():

			component._initialize(self)

	if state_machine:

		state_machine._initialize(self)

	return true





func _activate() -> void:

	_connect_signals()

	active = true

	if hitbox:

		hitbox._activate()

	if hurtbox:

		hurtbox._activate()

	if component_root:

		for component in component_root.get_children():

			component._activate()

	if state_machine:

		state_machine._activate()




func _deactivate() -> void:

	active = false

	if hitbox:

		hitbox._deactivate()

	if hurtbox:

		hurtbox._deactivate()

	if component_root:

		for component in component_root.get_children():

			component._deactivate()

	if state_machine:

		state_machine._deactivate()

	_disconnect_signals()





func _connect_signals() -> void:

	if pick_up_area:

		pick_up_area.body_entered.connect(_on_body_entered_pick_up_area)



func _disconnect_signals() -> void:

	if pick_up_area:

		pick_up_area.body_entered.disconnect(_on_body_entered_pick_up_area)





func load_entity_def(_entity_def: EntityDef) -> void:

	entity_def = _entity_def

	if entity_def.sprite_frames:

		animated_body_sprite.sprite_frames = entity_def.sprite_frames

		animated_body_sprite.play("default")

		animated_body_sprite.offset.y = entity_def.sprite_y_offset





func receive_damage_package(damage_package: DamagePackage) -> void:

	for component in component_root.get_children():

		if component.has_method("receive_damage_package"):

			component.receive_damage_package(damage_package)




func get_component(component_script: Script) -> Component:

	for component in component_root.get_children():

		if component.get_component_script() == component_script:

			return component

	return null




func get_interactable_component() -> InteractableComponent:

	for component in component_root.get_children():

		if component is InteractableComponent:

			return component

	return null




func get_mouse_dir(from_combat_root:= false) -> Vector2:

	var origin = global_position

	if from_combat_root:

		origin = combat_root.global_position

	return origin.direction_to(get_global_mouse_position())






func is_interactable() -> bool:

	for component in component_root.get_children():

		if component is InteractableComponent:

			return true

	if self is CharacterNode and entity_def.dialogue_library != null:

		return true

	return false




func _on_body_entered_pick_up_area(body: PhysicsBody2D) -> void:

	if body is ItemNode:

		inventory.add_stack(body.item_stack)

		body.queue_free.call_deferred()