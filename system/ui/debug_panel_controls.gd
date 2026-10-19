class_name DebugPanelControl extends PanelContainer




@export var behavior_panel_checkbox: CheckBox

@export var behavior_panel: Control







func _ready() -> void:

	behavior_panel.hide()

	behavior_panel_checkbox.toggled.connect(_on_behavior_panel_toggled)







func _on_behavior_panel_toggled(state: bool) -> void:

	behavior_panel.visible = state

