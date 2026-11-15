extends Popup

var combination

func set_text(combination):
	$NinePatchRect/CenterContainer/NinePatchRect/Label.text = (PoolStringArray(combination).join(""))
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
