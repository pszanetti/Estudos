extends NinePatchRect


func _ready() -> void:
	hide()
	pass

func collect_loot() -> void:
	show()
	$VBoxContainer/ItemList.add_item("Loot", load("res://GFX/Loot/suitcase.png"), false)
#	$VBoxContainer/ItemList.add_icon_item(load("res://GFX/Loot/suitcase.png"), false)
#	$VBoxContainer/ItemList.set_item_text(0, "Loot")
#	pass
