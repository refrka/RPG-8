class_name MouseConstructor extends MarginContainer



@export var texture_rect: TextureRect



var entity_def: EntityDef

var active:= false





func _ready() -> void:

	deactivate()

	Constructor.construction_mode_state_updated.connect(_on_construction_mode_state_updated)

	Constructor.construction_entity_updated.connect(_on_construction_entity_updated)




func activate() -> void:

	active = true

	show()



func deactivate() -> void:

	active = false

	hide()




func load_entity(_entity_def: EntityDef) -> void:

	entity_def = _entity_def

	size = Vector2.ZERO

	texture_rect.size = Vector2.ZERO

	if entity_def != null:

		texture_rect.set("texture", entity_def.icon_texture)

		size = entity_def.icon_texture.get_size()





func _on_construction_mode_state_updated(state: bool) -> void:

	if state == false:

		_on_construction_entity_updated()





func _on_construction_entity_updated() -> void:

	load_entity(Constructor.construction_entity)

	if !Constructor.construction_entity:

		texture_rect.texture = null

		deactivate()

	else:

		texture_rect.texture = Constructor.construction_entity.icon_texture

		activate()





func _unhandled_input(event: InputEvent) -> void:

	if !active:

		return

	if event is InputEventMouseButton and event.is_pressed() and entity_def:
	
		if event.button_index == 1:

			var entity_node = load(entity_def.scene_path).instantiate()

			entity_node.save_enabled = true

			Scenes.current_location.add_entity_node(entity_node, get_global_mouse_position())

			get_viewport().set_input_as_handled()

		elif event.button_index == 2:

			Constructor.set_construction_entity(null, null)





func _process(_delta: float) -> void:

	if active:

		global_position = get_global_mouse_position() - Vector2(get_rect().size.x / 2, get_rect().size.y)

	


