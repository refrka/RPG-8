class_name ProfileOverlay extends Overlay



@export var weapon_slot: ItemSlot

@export var armor_slot: ItemSlot

@export var accessory_slot: ItemSlot

@export var tool_slot: ItemSlot

@export var player_inventory_grid: InventoryGrid





func _ready() -> void:

	super()

	Events.subscribe(PlayerSaveLoadedEvent, _on_player_save_loaded)

	Events.subscribe(GameExitedEvent, _on_game_exited)

	weapon_slot.contents_updated.connect(_on_weapon_slot_contents_updated)

	armor_slot.contents_updated.connect(_on_armor_slot_contents_updated)

	accessory_slot.contents_updated.connect(_on_accessory_slot_contents_updated)

	tool_slot.contents_updated.connect(_on_tool_slot_contents_updated)






func _on_player_save_loaded(_event: Event) -> void:

	var player = Game.get_player()

	player_inventory_grid.load_inventory(player.inventory)

	weapon_slot.parent_inventory = player.inventory

	armor_slot.parent_inventory = player.inventory

	if player.inventory.weapon:

		var weapon_def = player.inventory.weapon.item_def

		var item_stack = ItemStack.create_new(weapon_def, 1, player.inventory.weapon)

		weapon_slot.set_stack(item_stack)






func _on_weapon_slot_contents_updated() -> void:

	var player = Game.get_player()

	var weapon_data: WeaponData = null

	if weapon_slot.item_stack and !weapon_slot.item_stack.is_empty():

		weapon_data = weapon_slot.item_stack.item_data

	player.inventory.set_weapon(weapon_data)



func _on_armor_slot_contents_updated() -> void:

	var player = Game.get_player()

	var armor_data: ArmorData = null

	if armor_slot.item_stack and !armor_slot.item_stack.is_empty():

		armor_data = armor_slot.item_stack.item_data

	player.inventory.set_armor(armor_data)



func _on_accessory_slot_contents_updated() -> void:

	var player = Game.get_player()

	var accessory_data: EquipmentData = null

	if accessory_slot.item_stack and !accessory_slot.item_stack.is_empty():

		accessory_data = accessory_slot.item_stack.item_data

	player.inventory.set_accessory(accessory_data)



func _on_tool_slot_contents_updated() -> void:

	var player = Game.get_player()

	var tool_data: EquipmentData = null

	if tool_slot.item_stack and !tool_slot.item_stack.is_empty():

		tool_data = tool_slot.item_stack.item_data

	player.inventory.set_tool(tool_data)




func _on_game_exited(_event: Event) -> void:

	weapon_slot.clear()

	armor_slot.clear()

	player_inventory_grid.clear()