class_name ItemNode extends EntityNode



@export var item_def: ItemDef

var item_stack: ItemStack




func load_item_def(_item_def: ItemDef) -> void:

	item_def = _item_def

	body_sprite.texture = item_def.sprite_texture

	body_sprite.position.y = -item_def.sprite_texture.get_height() / 2




static func create_new(_item_def: ItemDef, count:= 1) -> ItemNode:

	var item_node = load("res://system/entity/item_node.tscn").instantiate()

	item_node.load_item_def(_item_def)

	item_node.item_stack = ItemStack.create_new(_item_def, count)

	return item_node