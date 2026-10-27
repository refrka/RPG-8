class_name LootTable extends Resource



@export var entries: Array[LootEntry]

@export var conditions: Array[Condition]

@export var conditional_entries: Array[LootEntry]




func get_loot(roll: float) -> Dictionary[ItemDef, int]:

	var loot: Dictionary[ItemDef, int] = {}

	for entry in entries:

		if entry.disabled:

			continue

		var count:= 0

		if roll <= entry.base_chance:

			var add_count = randi_range(entry.count_range.x, entry.count_range.y)

			count += add_count

		if count > 0:

			if !loot.has(entry.item_def):

				loot[entry.item_def] = 0
		
			loot[entry.item_def] += count

			if entry.one_time:

				entry.disabled = true

	if !conditional_entries.is_empty():

		var passed:= true

		for condition in conditions:

			if !condition._evaluate():

				passed = false

			if !passed:

				break
		
		if passed:

			for entry in conditional_entries:

				if entry.disabled:

					continue

				var count:= randi_range(entry.count_range.x, entry.count_range.y)

				if count > 0:

					if !loot.has(entry.item_def):

						loot[entry.item_def] = 0
				
					loot[entry.item_def] += count

					if entry.one_time:

						entry.disabled = true

	return loot