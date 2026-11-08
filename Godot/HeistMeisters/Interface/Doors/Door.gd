extends Area2D

var can_click: bool = false
var doors_close = true


func _on_Door_body_entered(body: Node) -> void:
#	if body.name == "Player": ou
#	Checa se a area de colisão é do Player
#	print(body.collision_layer)
	if body.collision_layer == 1:
		can_click = true
	else:		# -> Permite que guardas passem sem o click ou senha
		open()
		pass
	pass



func _on_Door_body_exited(body: Node) -> void:
	if not doors_close:
		$AnimationPlayer.play("closeDoor")
		doors_close = true
	if body.collision_layer == 1:	# -> Remove a permissão quando o Player se afasta
		can_click = false
	pass # Replace with function body.


func _on_Door_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and can_click:
		open()
	pass # Replace with function body.

func open():
	doors_close = false
	$AnimationPlayer.play("openDoor")
	pass
