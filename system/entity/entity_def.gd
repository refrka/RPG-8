class_name EntityDef extends Resource


enum EntityType {

	NPC,

	BEAST,

	SPIRIT,

}


@export var entity_id: StringName

@export var display_name: StringName

@export var scene_path: String


@export var initial_inventory: Inventory

@export var base_health:= 10.0

@export var sprite_frames: SpriteFrames

@export var sprite_texture: Texture2D

@export var icon_texture: Texture2D

@export var sprite_coords:= Vector2i(1,1)

@export var sprite_offset:= Vector2.ZERO

@export var move_speed:= 150.0