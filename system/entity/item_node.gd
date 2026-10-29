class_name ItemNode extends EntityNode



@export var item_def: ItemDef

var item_stack: ItemStack

var floating_to_entity: EntityNode





func _ready() -> void:

	await Game.get_timer(0.2).timeout

	body_collision.disabled = false





func load_item_def(_item_def: ItemDef) -> void:

	item_def = _item_def

	body_sprite.texture = item_def.sprite_texture

	@warning_ignore("integer_division")

	body_sprite.offset.y = -item_def.sprite_texture.get_height() / 2

	center_marker.position.y = body_sprite.offset.y



func float_to_entity(entity_node: EntityNode) -> void:

	floating_to_entity = entity_node

	body_canvas_group.y_sort_enabled = false




static func create_new(_item_def: ItemDef, count:= 1) -> ItemNode:

	var item_node = load("res://system/entity/item_node.tscn").instantiate()

	item_node.load_item_def(_item_def)

	item_node.item_stack = ItemStack.create_new(_item_def, count)

	return item_node




func _on_floating_to_entity_reached() -> void:

	queue_free.call_deferred()




func _physics_process(_delta: float) -> void:

	if floating_to_entity != null:

		var target_position = global_position + (get_distance(floating_to_entity, true) - 8) * get_direction(floating_to_entity, true)

		global_position = global_position.move_toward(target_position, 0.5)

		if global_position.distance_to(target_position) <= 1.0:

			queue_free.call_deferred()



