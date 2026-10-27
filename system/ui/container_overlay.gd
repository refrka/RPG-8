class_name ContainerOverlay extends Overlay



@export var container_inventory_grid: InventoryGrid

@export var player_inventory_grid: InventoryGrid








func load_container_inventory(container_inventory: Inventory) -> void:

	container_inventory_grid.load_inventory(container_inventory)

	var player = Game.get_player()

	player_inventory_grid.load_inventory(player.inventory)

	container_inventory_grid.pair_inventory(player.inventory)

	player_inventory_grid.pair_inventory(container_inventory)

	





func clear() -> void:

	container_inventory_grid.clear()

	player_inventory_grid.clear()
