class_name InteractionArea extends Area2D


signal interactable_entity_entered_area(entity_node: EntityNode)

signal interactable_entity_exited_area(entity_node: EntityNode)


var entity: EntityNode


func _ready() -> void:

	body_entered.connect(_on_body_entered_area)

	body_exited.connect(_on_body_exited_area)




func _initialize(_entity: EntityNode) -> void:

	entity = _entity





func get_nearest_interactable_entity() -> EntityNode:

	var nearest_entity: EntityNode = null

	var nearest_distance:= INF

	for body in get_overlapping_bodies():

		if body is EntityNode and body.is_interactable():

			var distance = entity.global_position.distance_squared_to(body.global_position)

			if !nearest_entity or distance < nearest_distance:

				nearest_entity = body

				nearest_distance = distance

	return nearest_entity





func _on_body_entered_area(body: PhysicsBody2D) -> void:

	if body is EntityNode and body.is_interactable():

		interactable_entity_entered_area.emit(body)



func _on_body_exited_area(body: PhysicsBody2D) -> void:

	if body is EntityNode and body.is_interactable():

		interactable_entity_exited_area.emit(body)