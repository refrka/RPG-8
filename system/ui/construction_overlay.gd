class_name ConstructionOverlay extends Overlay



@onready var construction_entity_slot_scene:= preload("res://system/ui/construction/construction_entity_slot.tscn")


@export var entity_grid: GridContainer


func _ready() -> void:

	super()

	Constructor.construction_mode_state_updated.connect(_on_construction_mode_state_updated)

	for entity_def in Defs.entity_defs.values():

		var entity_slot = construction_entity_slot_scene.instantiate() as ConstructionEntitySlot

		entity_slot.set_entity_def(entity_def)

		entity_grid.add_child(entity_slot)



func _on_construction_mode_state_updated(state: bool) -> void:

	visible = state