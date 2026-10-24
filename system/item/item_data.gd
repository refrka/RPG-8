class_name ItemData extends Resource




@export var item_def: ItemDef

@export var durability:= 1.0




func to_dict() -> Dictionary:

	return {

		"item_id": item_def.item_id,

		"durability": durability,

	}




static func from_dict(dict: Dictionary) -> ItemData:

	var def = Defs.get_item_def(dict["item_id"])

	var item_data: ItemData = null

	if def is WeaponDef:

		item_data = WeaponData.new()

		if dict["ammunition_stack"] != null:

			item_data.ammunition_stack = ItemStack.from_dict(dict["ammunition_stack"])

	elif def is ArmorDef:

		item_data = ArmorData.new()

	item_data.item_def = Defs.get_item_def(dict["item_id"])

	item_data.durability = dict["durability"]

	return item_data