class_name Player extends CharacterNode



@export var interaction_area: InteractionArea

var current_spawn_id: StringName





func _initialize() -> bool:

	if !super():

		return false

	interaction_area._initialize(self)

	Events.fire(PlayerInitializedEvent)

	return true






func _activate() -> void:

	super()

	interaction_area.monitoring = true



func _deactivate() -> void:

	super()

	interaction_area.monitoring = false





func load_save_data(dict: Dictionary) -> void:

	inventory.clear()

	inventory.resize(dict["inventory"]["size"])

	for i in range(dict["inventory"]["size"]):

		var item_stack_dict = dict["inventory"]["stacks"][i]

		if item_stack_dict == null:

			inventory.set_slot_stack(i, null)

		else:

			var stack = ItemStack.from_dict(item_stack_dict)

			inventory.set_slot_stack(i, stack)

	if dict["inventory"]["weapon"] != null:

		inventory.set_weapon(ItemData.from_dict(dict["inventory"]["weapon"]))

	if dict["inventory"]["armor"] != null:

		inventory.set_armor(ItemData.from_dict(dict["inventory"]["armor"]))

	for component in component_root.get_children():

		var component_name = component.get_component_name()

		if dict["components"].has(component_name):

			component._load_dict(dict["components"][component_name])

	Events.fire(PlayerSaveLoadedEvent)



func get_save_data() -> Dictionary:

	var save_dict = Game.active_save_data

	save_dict["location_id"] = Scenes.get_location_id()

	save_dict["spawn_id"] = current_spawn_id

	save_dict["inventory"] = inventory.to_dict()

	for component in component_root.get_children():

		save_dict["components"][component.get_component_name()] = component._to_dict()

	return save_dict
			


func load_template() -> Dictionary:

	var template_dict = Game.get_save_template()

	var initial_inventory = entity_def.initial_inventory.duplicate(true)

	initial_inventory.resize()

	template_dict["inventory"] = initial_inventory.to_dict()

	for component in component_root.get_children():

		component._clear()

	return template_dict



	


func _die() -> void:

	super()

	Game.exit()
