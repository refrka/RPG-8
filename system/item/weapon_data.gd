class_name WeaponData extends EquipmentData



@export var ammunition_stack: ItemStack






func to_dict() -> Dictionary:

	var dict = super()

	dict["ammunition_stack"] = null

	if ammunition_stack:

		dict["ammunition_stack"] = ammunition_stack.to_dict()

	return dict