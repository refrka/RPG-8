extends Node



@onready var item_notice_scene:= preload("res://system/ui/notice/item_notice_panel.tscn")



var notice_root: Control


var active_item_notice_panel: ItemNoticePanel

var pending_item_notices: Array[ItemNotice]




func _ready() -> void:

	notice_root = get_tree().get_first_node_in_group("notice_root")

	Events.subscribe(InventoryNoticeEvent, _on_inventory_notice_event)







func add_notice(notice: Notice) -> void:

	if notice is ItemNotice:

		pending_item_notices.append(notice)

		if !active_item_notice_panel:

			_next_item_notice()







func _next_item_notice() -> void:

	var notice = pending_item_notices.pop_front()

	var item_notice_panel = item_notice_scene.instantiate()

	item_notice_panel._load_notice(notice)

	_add_item_notice_panel(item_notice_panel)








func _add_item_notice_panel(item_notice_panel: ItemNoticePanel) -> void:

	notice_root.add_child(item_notice_panel)

	item_notice_panel.expired.connect(_on_item_notice_panel_expired.bind(item_notice_panel))

	active_item_notice_panel = item_notice_panel

	item_notice_panel._activate()










func _on_inventory_notice_event(event: Event) -> void:

	var item_stack = event.data["item_stack"]

	if active_item_notice_panel:

		if active_item_notice_panel.item_slot.item_stack.get_item_def() == item_stack.get_item_def() and active_item_notice_panel.added == event.data["added"]:

			active_item_notice_panel.update_notice_count(item_stack.count)

			item_stack.remove_amount(item_stack.count)

	for item_notice in pending_item_notices:

		if item_notice.item_def == item_stack.get_item_def() and event.data["added"] == item_notice.added:

			item_notice.amount += item_stack.count

			item_stack.remove_amount(item_notice.amount)

			break

	if item_stack.is_empty():

		return

	var notice = ItemNotice.generate_notice(item_stack.get_item_def(), item_stack.count, event.data["added"])

	add_notice(notice)




func _on_item_notice_panel_expired(item_notice_panel: ItemNoticePanel) -> void:

	if active_item_notice_panel == item_notice_panel:

		active_item_notice_panel = null

		item_notice_panel.queue_free()

		if !pending_item_notices.is_empty():

			_next_item_notice()


