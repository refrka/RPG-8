class_name ProfileOverlay extends Overlay



@export var player_inventory_grid: InventoryGrid



func _ready() -> void:

	super()

	Events.subscribe(PlayerInitializedEvent, _on_player_initialized)




func _on_player_initialized(_event: Event) -> void:

	var player = Game.get_player()

	player_inventory_grid.load_inventory(player.inventory)