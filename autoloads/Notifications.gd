extends Node




@onready var inventory_notification_scene:= preload("res://system/ui/inventory_notification.tscn")



var notification_root: Control


var pending_notifications: Array[Notification]

var active_notification: Notification






func _ready() -> void:

	notification_root = get_tree().get_first_node_in_group("notification_root")





func new_inventory_notification(item_def: ItemDef, amount: int, added: bool) -> void:

	if active_notification:
		
		if active_notification is InventoryNotification:

			if active_notification.item_def == item_def and active_notification.added == added:

				active_notification.update_count(amount)

				return

	for pending_notif in pending_notifications:

		if pending_notif is InventoryNotification and pending_notif.item_def == item_def and pending_notif.added == added:

			pending_notif.update_count(amount)

			return

	var notif = inventory_notification_scene.instantiate()

	notif.set_notification(item_def, amount, added)

	_add_notification(notif)





func _add_notification(notif: Notification) -> void:

	pending_notifications.append(notif)




func _next_notification() -> void:

	var notif = pending_notifications.pop_front()

	active_notification = notif

	notif.expired.connect(_on_notif_expired.bind(notif))

	notif.dismissed.connect(_on_notif_dismissed.bind(notif))

	notification_root.add_child(notif)

	notif.anim_player.play("drop")





func _on_notif_expired(notif: Notification) -> void:

	if notif == active_notification:

		active_notification = null

		notif.anim_player.play("fade")



func _on_notif_dismissed(notif: Notification) -> void:

	if notif == active_notification:

		active_notification = null

		notif.anim_player.play("fade")





func _process(_delta: float) -> void:

	if !active_notification and !pending_notifications.is_empty():

		_next_notification()