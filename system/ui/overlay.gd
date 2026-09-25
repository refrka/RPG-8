class_name Overlay extends Control



@export var pause:= false



func _ready() -> void:

	UI.register_overlay(self)