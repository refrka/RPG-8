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

	if dict["fresh_save"] == false:

		inventory.clear()

	inventory.load_dict(dict["inventory"])

	for component in component_root.get_children():

		var component_name = component.get_component_name()

		if dict["components"].has(component_name) and component.has_method("load_dict"):

			component.load_dict(dict["components"][component_name])

	Events.fire(PlayerSaveLoadedEvent)



func get_save_data() -> Dictionary:

	var save_dict = Game.active_save_data.duplicate()

	save_dict["location_id"] = Scenes.get_location_id()

	save_dict["spawn_id"] = current_spawn_id

	save_dict["inventory"] = inventory.to_dict()

	for component in component_root.get_children():

		if not component.has_method("to_dict"):

			continue

		save_dict["components"][component.get_component_name()] = component.to_dict()

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
