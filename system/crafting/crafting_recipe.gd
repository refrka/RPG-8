class_name CraftingRecipe extends Resource


@export var recipe_id: StringName

@export var required_furnishings: Array[ObjectDef]

@export var required_item_list: Dictionary[ItemDef, int]

@export var product_stack: ItemStack