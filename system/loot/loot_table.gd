class_name LootTable extends Resource



@export var entries: Array[LootEntry]






func get_loot(roll: float) -> Dictionary[ItemDef, int]:

	var loot: Dictionary[ItemDef, int] = {}

	for entry in entries:

		if roll <= entry.base_chance:

			var count = randi_range(entry.count_range.x, entry.count_range.y)

			loot[entry.item_def] = count

	return loot