class_name ContainerOverlay extends Overlay



@export var container_inventory_grid: InventoryGrid

@export var player_inventory_grid: InventoryGrid








func load_container_inventory(inventory: Inventory) -> void:

	container_inventory_grid.load_inventory(inventory)

	var player = Game.get_player()

	player_inventory_grid.load_inventory(player.inventory)





func clear() -> void:

	container_inventory_grid.clear()

	player_inventory_grid.clear()
