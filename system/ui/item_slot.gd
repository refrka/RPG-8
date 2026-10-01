class_name ItemSlot extends MarginContainer






@export_group("Node Exports")

@export var panel: PanelContainer

@export var count_label: Label

@export var texture_rect: TextureRect




var item_stack: ItemStack





func set_stack(_item_stack: ItemStack) -> void:

	item_stack = _item_stack

	if item_stack and !item_stack.is_empty():

		count_label.text = str(item_stack.count)

		texture_rect.texture = item_stack.item_def.sprite_texture

	else:

		clear()




func clear() -> void:

	count_label.text = ""

	texture_rect.texture = null


