class_name CombatComponent extends Component





var current_attack_config: AttackConfig

var current_attack_index:= 0

var current_attack_dir:= Vector2.ZERO

var current_library_name: String

var current_animation_name: String



var buffer_enabled:= false

var buffered:= false




var movement_component: MovementComponent





func _initialize(_entity: EntityNode) -> void:

	super(_entity)

	var attacking_state = entity.state_machine.get_state(CombatAttackingState)

	attacking_state.attack_complete.connect(_on_attack_complete)

	var input_component = entity.get_component(InputComponent)

	if input_component:

		input_component.dodge_pressed.connect(_on_dodge_input_pressed)

		input_component.attack_pressed.connect(_on_attack_input_pressed)

		input_component.attack_released.connect(_on_attack_input_released)

	movement_component = entity.get_component(MovementComponent)

	if entity.inventory:

		pass

	if not current_attack_config:

		current_attack_config = entity.entity_def.unarmed_attack_config

		current_library_name = "unarmed"






func _try_attack() -> void:

	if is_attacking():

		if buffer_enabled:

			buffered = true

			return

	if !current_attack_config:

		return

	var attack_entry = get_attack_entry(current_attack_index)

	if !attack_entry:

		return

	_start_attack()

	






func _start_attack() -> void:

	current_animation_name = get_attack_animation_name()

	current_attack_dir = get_attack_dir()

	entity.hitbox.current_damage_package = get_damage_package()

	entity.combat_root.rotation = current_attack_dir.angle()

	entity.state_machine.request_state(CombatAttackingState)






func _complete_attack() -> void:

	current_animation_name = ""

	entity.hitbox.clear_hit_list()

	entity.hitbox.current_damage_package = null

	if buffered:

		var next_index = current_attack_index + 1

		var attack_entry = get_attack_entry(next_index)

		if attack_entry:

			current_attack_index = next_index

			_start_attack()

	_end_attack()





func _end_attack() -> void:

	entity.state_machine.request_state(CombatIdleState)











func is_attacking() -> bool:

	return entity.state_machine.current_combat_state is CombatAttackingState



func is_charging() -> bool:

	return entity.state_machine.current_combat_state is CombatChargingState










func get_attack_entry(index: int) -> AttackEntry:

	if current_attack_config and current_attack_config.attack_set.size() - 1 >= index:

		return current_attack_config.attack_set[index]
	
	return null




func get_attack_dir() -> Vector2:

	if entity is Player:

		return entity.get_mouse_dir()

	else:

		return movement_component.face_dir




func get_attack_animation_name() -> String:

	return "%s/attack_%s" % [current_library_name, current_attack_index]





func get_damage_package() -> DamagePackage:

	var damage_package = DamagePackage.new()

	damage_package.damage_vector = current_attack_dir

	var attack_entry = get_attack_entry(current_attack_index)

	var damage_entry = DamageEntry.from_attack_entry(attack_entry)

	damage_package.damage_entries.append(damage_entry)

	return damage_package





func set_attack_config(attack_config: AttackConfig) -> void:

	current_attack_config = attack_config












func _on_attack_complete() -> void:

	_complete_attack()




func _on_dodge_input_pressed() -> void:

	var modifier = Modifier.new_modifier(900.0, 0.1)

	movement_component.modifier_handler.add_modifier(modifier)



func _on_attack_input_pressed() -> void:

	_try_attack()



func _on_attack_input_released() -> void:

	pass



func _on_weapon_slot_stack_updated(weapon_slot: InventorySlot) -> void:

	if !weapon_slot.is_empty():

		var weapon_def = weapon_slot.item_stack.item_def

		current_attack_config = weapon_def.attack_config

		current_library_name = weapon_def.item_id		

	else:

		current_attack_config = entity.entity_def.unarmed_attack_config

		current_library_name = "unarmed"