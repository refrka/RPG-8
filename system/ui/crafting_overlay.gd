class_name CraftingOverlay extends Overlay


@onready var recipe_row_scene:= preload("res://system/ui/crafting/crafting_overlay_recipe_row.tscn")




@export var crafting_object_title_label: Label

@export var crafting_recipe_title_label: Label

@export var recipe_list: VBoxContainer








func clear() -> void:

	pass







func _on_cancel_pressed() -> void:

	pass



func _on_craft_pressed() -> void:

	pass