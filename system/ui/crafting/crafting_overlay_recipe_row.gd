class_name CraftingOverlayRecipeRow extends MarginContainer




@export var required_items_hbox: HBoxContainer

@export var product_item_slot: ItemSlot


var recipe: CraftingRecipe






func load_recipe(_recipe: CraftingRecipe) -> void:

	recipe = _recipe





func _add_required_item(item_def: ItemDef) -> void:

	pass