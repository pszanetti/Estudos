extends ItemList


func update_disguises(number) -> void:
	clear()
	for disguises in range(number):
		add_icon_item(load("res://GFX/PNG/Tiles/tile_130.png"), false)
		pass
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


