extends Area2D


var can_click: bool = false
var doors_close = true
onready var animation = $AnimationPlayer

func _ready() -> void:
	$Label.rect_rotation = - rotation_degrees


func _on_LockedDoor_input_event(_viewport: Node, _event: InputEvent, _shape_idx: int) -> void:
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and can_click:
		$CanvasLayer
		$CanvasLayer/NumPad.popup_centered()
#		print("Cadê o Popup")


func _on_LockedDoor_body_entered(body: Node) -> void:
	#	if body.name == "Player": ou
#	Checa se a area de colisão é do Player
#	print(body.collision_layer)
	if body.collision_layer == 1 or body.collision_layer == 16:
		can_click = true
	else:		# -> Permite que guardas passem sem o click ou senha
		open()
	pass



func _on_LockedDoor_body_exited(body: Node) -> void:
#	print(doors_close)
	if ! doors_close:
		animation.play("closeDoor")
		doors_close = true
	if body.collision_layer == 1 or body.collision_layer == 16:	# -> Remove a permissão quando o Player se afasta
		can_click = false
		$CanvasLayer/NumPad.hide()
	pass # Replace with function body.

func _on_NumPad_combination_correct() -> void:
	$AnimationPlayer.play("openDoor")
	$CanvasLayer/NumPad.hide()
	doors_close = false

	
func open():
	doors_close = false
	animation.play("openDoor")
	pass


func _on_Computer_combination_emited(numbers, lock_group) -> void:
	$Label.text = lock_group
	$CanvasLayer/NumPad.combination = numbers
	pass # Replace with function body.
