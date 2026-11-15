extends Node2D

var can_click = false

onready var computer_popup: Popup = $CanvasLayer/ComputerPopup

signal combination_emited

export var lock_group = "Unset"

var combination

export var combination_lenght: int = 6
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label.text = lock_group
	$ComputerON.enabled = false
	generate_combination()
	emit_signal("combination_emited", combination, lock_group)
	$Label.rect_rotation = - rotation_degrees
	pass # Replace with function body.

func generate_combination():
	combination = CombinationGenerator.generate_combination(combination_lenght)
	print(combination)
	set_popup_text()

func set_popup_text():
	computer_popup.set_text(combination)

func _on_Area2D_body_entered(body: Node) -> void:
#	print("entrou: ", body.name, " | ", body.get_path(), " | camada: ", body.collision_layer)
#	if body.name == "Player":
	can_click = true
	$ComputerON.enabled = true
	pass # Replace with function body.


func _on_Area2D_body_exited(body: Node) -> void:
	can_click = false
	$ComputerON.enabled = false
	$CanvasLayer/ComputerPopup.hide()


func _on_Area2D_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and can_click:
		$CanvasLayer/ComputerPopup.popup_centered()
		pass
	pass # Replace with function body.
