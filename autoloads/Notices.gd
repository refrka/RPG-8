extends Node





var notice_root: Control


var item_notices: Array[ItemNotice]




func _ready() -> void:

	notice_root = get_tree().get_first_node_in_group("notice_root")