extends "res://Interface/Doors/Door.gd"

func _on_Door_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and can_click:
		$CanvasLayer/NumPad.popup_centered()
		
func _on_Door_body_exited(body: Node) -> void:
	if not doors_close:
		$AnimationPlayer.play("closeDoor")
	if body.collision_layer == 1:	# -> Remove a permissão quando o Player se afasta
		can_click = false
		$CanvasLayer/NumPad.hide()
		doors_close = true

func _ready() -> void:
	generate_combination()

func _on_NumPad_combination_correct() -> void:
	open()
	$CanvasLayer/NumPad.hide()

func generate_combination():
	var length = 6
	var combination = CombinationGenerator.generate_combination(length)
	$CanvasLayer/NumPad.combination = combination
	print(combination)
	
	
	
