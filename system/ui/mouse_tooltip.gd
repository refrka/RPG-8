class_name MouseTooltip extends MarginContainer




@export var primary_label: Label

@export var ammunition_count_label: Label

@export var ammunition_section: MarginContainer

@export var ammunition_slot: ItemSlot



var active:= false



func _ready() -> void:

	deactivate()





func activate() -> void:

	active = true

	visible = true




func deactivate() -> void:

	active = false

	visible = false







func show_item_tooltip(item_def: ItemDef, _ammunition_def: AmmunitionDef = null, _ammunition_count:= -1) -> void:

	activate()

	primary_label.text = item_def.display_name

	if _ammunition_def:

		ammunition_section.visible = true

		ammunition_count_label.text = "x %s" % _ammunition_count

		ammunition_slot.set_stack(ItemStack.create_new(_ammunition_def, 1))

	else:

		ammunition_section.visible = false

	size = Vector2.ZERO








func _process(_delta: float) -> void:

	if !active:

		return

	global_position = get_global_mouse_position()