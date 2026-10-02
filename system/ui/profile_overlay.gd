class_name ProfileOverlay extends Overlay



@export var player_inventory_grid: InventoryGrid








func _activate() -> void:

	super()

	var player = Game.get_player()

	player_inventory_grid.load_inventory(player.inventory)




func _deactivate() -> void:

	super()

	player_inventory_grid.clear()


