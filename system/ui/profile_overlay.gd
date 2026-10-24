class_name ProfileOverlay extends Overlay



@export var weapon_slot: ItemSlot

@export var armor_slot: ItemSlot

@export var player_inventory_grid: InventoryGrid





func _ready() -> void:

	super()

	Events.subscribe(PlayerInitializedEvent, _on_player_initialized)

	weapon_slot.contents_updated.connect(_on_weapon_slot_contents_updated)






func _on_player_initialized(_event: Event) -> void:

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