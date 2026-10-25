class_name LootTable extends Resource



@export var entries: Array[LootEntry]






func get_loot(roll: float) -> Dictionary[ItemDef, int]:

	var loot: Dictionary[ItemDef, int] = {}

	for entry in entries:

		var count:= 0

		if roll <= entry.base_chance:

			var add_count = randi_range(entry.count_range.x, entry.count_range.y)

			count += add_count

		if count > 0:

			if !loot.has(entry.item_def):

				loot[entry.item_def] = 0
		
			loot[entry.item_def] += count

	return loot