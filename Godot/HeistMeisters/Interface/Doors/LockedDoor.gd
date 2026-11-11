extends Area2D


var can_click: bool = false
var doors_close = true
onready var animation = $AnimationPlayer

func _ready() -> void:
	generate_combination()


func _on_LockedDoor_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and can_click:
		$CanvasLayer
		$CanvasLayer/NumPad.popup_centered()
#		print("Cadê o Popup")


func _on_LockedDoor_body_entered(body: Node) -> void:
	#	if body.name == "Player": ou
#	Checa se a area de colisão é do Player
#	print(body.collision_layer)
	if body.collision_layer == 1:
		can_click = true
	else:		# -> Permite que guardas passem sem o click ou senha
		open()
		pass
	pass
	pass # Replace with function body.


func _on_LockedDoor_body_exited(body: Node) -> void:
#	print(doors_close)
	if ! doors_close:
		animation.play("closeDoor")
		doors_close = true
	if body.collision_layer == 1:	# -> Remove a permissão quando o Player se afasta
		can_click = false
		$CanvasLayer/NumPad.hide()
	pass # Replace with function body.

func _on_NumPad_combination_correct() -> void:
	$AnimationPlayer.play("openDoor")
	$CanvasLayer/NumPad.hide()
	doors_close = false

func generate_combination():
	var length = 6
	var combination = CombinationGenerator.generate_combination(length)
	$CanvasLayer/NumPad.combination = combination
	print(combination)
	
func open():
	doors_close = false
	animation.play("openDoor")
	pass
