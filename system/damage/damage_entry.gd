class_name DamageEntry extends RefCounted



@export var amount: float






static func from_attack_entry(attack_entry: AttackEntry) -> DamageEntry:

	var damage_entry = DamageEntry.new()

	damage_entry.amount = randf_range(attack_entry.damage_range.x, attack_entry.damage_range.y)

	return damage_entry