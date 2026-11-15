extends Node2D

var can_click = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_Area2D_body_entered(body: Node) -> void:
	can_click = true
	pass # Replace with function body.


func _on_Area2D_body_exited(body: Node) -> void:
	can_click = false
	$CanvasLayer/ComputerPopup.hide()


func _on_Area2D_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and can_click:
		$CanvasLayer/ComputerPopup.popup_centered()
		pass
	pass # Replace with function body.
