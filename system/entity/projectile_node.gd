class_name ProjectileNode extends EntityNode


@export var on_screen_notifier: VisibleOnScreenNotifier2D


var projectile_owner: EntityNode

var projectile_def: ProjectileDef





func _initialize() -> bool:

	if !super():

		return false

	on_screen_notifier.screen_exited.connect(_on_projectile_exited_screen)

	return true




func set_trajectory(trajectory: Vector2) -> void:

	var projectile_component = get_component(ProjectileComponent)

	projectile_component.set_trajectory(trajectory)





func set_projectile_def(_projectile_def: ProjectileDef) -> void:

	projectile_def = _projectile_def

	if projectile_def.sprite_frames:

		animated_body_sprite.sprite_frames = projectile_def.sprite_frames

	animated_body_sprite.offset = projectile_def.sprite_offset

	hitbox.collision_shape.shape = projectile_def.projectile_hitbox_collision_shape





static func new_projectile(_projectile_def: ProjectileDef, initial_trajectory: Vector2, _owner: EntityNode) -> ProjectileNode:

	var projectile = load("res://system/entity/projectile_node.tscn").instantiate()

	projectile._initialize()

	projectile.set_projectile_def(_projectile_def)

	projectile.set_trajectory(initial_trajectory)

	projectile.projectile_owner = _owner

	return projectile





func _on_projectile_exited_screen() -> void:

	var projectile_component = get_component(ProjectileComponent)

	projectile_component._start_expiration_timer()