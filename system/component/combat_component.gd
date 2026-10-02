class_name CombatComponent extends Component





var current_attack_config: AttackConfig

var current_attack_index:= 0

var current_attack_dir:= Vector2.ZERO

var current_library_name: String

var current_animation_name: String



var buffer_enabled:= false

var buffered:= false

var charged:= false



var movement_component: MovementComponent





func _initialize(_entity: EntityNode) -> void:

	super(_entity)

	var attacking_state = entity.state_machine.get_state(CombatAttackingState)

	attacking_state.attack_complete.connect(_on_attack_complete)

	var charging_state = entity.state_machine.get_state(CombatChargingState)

	charging_state.charge_complete.connect(_on_charge_complete)

	var input_component = entity.get_component(InputComponent)

	if input_component:

		input_component.dodge_pressed.connect(_on_dodge_input_pressed)

		input_component.attack_pressed.connect(_on_attack_input_pressed)

		input_component.attack_released.connect(_on_attack_input_released)

	movement_component = entity.get_component(MovementComponent)

	if entity.inventory and entity.inventory.weapon:

		var weapon_def = entity.inventory.weapon.item_def

		set_attack_config(weapon_def.attack_config)

		current_library_name = weapon_def.item_id

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

	if !attack_entry.has_charge:

		_start_attack()

	else:

		_start_charge()

	






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

	buffered = false

	charged = false

	current_attack_index = 0

	entity.state_machine.request_state(CombatIdleState)





func _start_charge() -> void:

	current_animation_name = get_charge_animation_name()

	current_attack_dir = get_attack_dir()

	entity.state_machine.request_state(CombatChargingState)

	entity.combat_root.rotation = current_attack_dir.angle()





func _complete_charge() -> void:

	charged = true

	var attack_entry = get_attack_entry(current_attack_index)

	if !attack_entry.can_hold_charge:

		_start_attack()





func _cancel_change() -> void:

	current_animation_name = ""

	_end_attack()






func _generate_projectile() -> void:

	var weapon_data = entity.inventory.weapon

	if weapon_data.ammunition_stack and !weapon_data.ammunition_stack.is_empty():

		var projectile_def = weapon_data.ammunition_stack.item_def

		var projectile_node = ProjectileNode.new_projectile(projectile_def, current_attack_dir, entity)

		projectile_node.hitbox.current_damage_package = get_damage_package()

		Scenes.current_location.add_entity_node(projectile_node, entity.combat_root.global_position)

		projectile_node.rotation = current_attack_dir.angle()

		projectile_node._activate()

		weapon_data.ammunition_stack.remove_amount(1)











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

		return entity.get_mouse_dir(true)

	else:

		return movement_component.face_dir




func get_attack_animation_name() -> String:

	return "%s/attack_%s" % [current_library_name, current_attack_index]



func get_charge_animation_name() -> String:

	return "%s/charge_%s" % [current_library_name, current_attack_index]




func get_damage_package() -> DamagePackage:

	var damage_package = DamagePackage.new()

	damage_package.damage_vector = current_attack_dir

	var attack_entry = get_attack_entry(current_attack_index)

	var damage_entry = DamageEntry.from_attack_entry(attack_entry)

	damage_package.damage_entries.append(damage_entry)

	damage_package.attack_entry = attack_entry

	return damage_package





func set_attack_config(attack_config: AttackConfig) -> void:

	current_attack_config = attack_config












func _on_attack_complete() -> void:

	_complete_attack()



func _on_charge_complete() -> void:

	_complete_charge()



func _on_dodge_input_pressed() -> void:

	var modifier = Modifier.new_modifier(900.0, 0.1)

	movement_component.modifier_handler.add_modifier(modifier)



func _on_attack_input_pressed() -> void:

	_try_attack()



func _on_attack_input_released() -> void:

	if is_charging():

		if !charged:

			_cancel_change()

		else:

			_start_attack()







func _process(_delta: float) -> void:

	if is_charging():

		var attack_entry = get_attack_entry(current_attack_index)
		
		if attack_entry.can_aim_charge:

			current_attack_dir = get_attack_dir()

			entity.combat_root.rotation = current_attack_dir.angle()