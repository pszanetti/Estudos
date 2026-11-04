extends "res://Interface/Doors/Door.gd"

func _on_Door_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and can_click:
		$CanvasLayer/NumPad.popup_centered()
		
