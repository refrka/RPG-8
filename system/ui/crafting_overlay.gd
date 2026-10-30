class_name CraftingOverlay extends Overlay


@onready var recipe_row_scene:= preload("res://system/ui/crafting/crafting_overlay_recipe_row.tscn")




@export var crafting_source_title_label: Label

@export var crafting_recipe_title_label: Label

@export var recipe_list_vbox: VBoxContainer


var crafting_source: ObjectNode

var shown_recipes: Dictionary[StringName, CraftingRecipe]









func load_crafting_source(_crafting_source: ObjectNode) -> void:

	crafting_source = _crafting_source

	var recipe_list = crafting_source.entity_def.recipe_list
	
	for recipe in recipe_list:

		var recipe_row = recipe_row_scene.instantiate()

		recipe_list_vbox.add_child(recipe_row)

	crafting_source_title_label.text = crafting_source.entity_def.display_name







func clear() -> void:

	pass




func _on_cancel_pressed() -> void:

	pass




func _on_craft_pressed() -> void:

	pass