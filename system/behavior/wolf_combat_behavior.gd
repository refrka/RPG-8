class_name WolfCombatBehavior extends Behavior



enum Phase {

	REPOSITION,

	FLANK,

	ATTACK,

}



var target_entity: EntityNode



func _start(_data:= {}) -> void:

	super(_data)

	target_entity = data["target_entity"]




func _start_phase(phase: Phase) -> void:

	match phase:

		Phase.REPOSITION:

			pass

		Phase.FLANK:

			pass




func _get_flanking_partner() -> CharacterNode:

	var flanking_partner: CharacterNode = null

	for body in actor.vision_area.get_overlapping_bodies():

		if body is CharacterNode and body.entity_def.entity_id == "wolf":

			flanking_partner = body

	return flanking_partner