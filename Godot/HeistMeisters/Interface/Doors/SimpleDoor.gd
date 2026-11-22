extends Area2D

var can_click: bool = false
var door_close = true
var bodies_inside = 0
var side = "A"   # lado para onde a porta abriu
var last_player = null

func open(body: Node) -> void:
	if not door_close:
		return
	door_close = false
	# em que lado da porta o corpo está (ajuste o eixo: .y se a porta é horizontal, .x se é vertical)
	side = "A" if to_local(body.global_position).y > 0 else "B"
	$AnimationPlayer.play("OpenDoor" + side)

func close_if_empty() -> void:
	yield(get_tree().create_timer(0.5), "timeout")
	if not door_close:
#	if bodies_inside == 0 and not door_close:
		$AnimationPlayer.play("CloseDoor" + side)
		door_close = true

func _on_SimpleDoor_body_entered(body: Node) -> void:
#	bodies_inside += 1
	open(body)
#	if body.collision_layer == 1:
#		can_click = true
#		last_player = body
#	else:		# -> guardas abrem sem click
#		open(body)

func _on_SimpleDoor_body_exited(body: Node) -> void:
#	bodies_inside = max(bodies_inside - 1, 0)
#	if body.collision_layer == 1:
#		can_click = false
#	if bodies_inside == 0:
#		close_if_empty()
	close_if_empty()


func _on_SimpleDoor_input_event(_viewport: Node, _event: InputEvent, _shape_idx: int) -> void:
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and can_click:
		open(last_player)
