extends CanvasModulate

const DARK: Color = Color("313131") 
const NIGHTVISION: Color = Color("3fa237")


var cooldown = false

func _ready() -> void:
	color = DARK
	pass

func cyclo_vision_mode() -> void:
	if not cooldown:
		if color == NIGHTVISION:
			DARK_mode()
		else:
			NIGHTVISION_mode()
		cooldown = true
		$Timer.start()
	
func DARK_mode() -> void:
	color = DARK
	$AudioStreamPlayer2D.stream = load("res://SFX/nightvision_off.wav")
	$AudioStreamPlayer2D.play()
#	alternar_luzes(true)
	
func NIGHTVISION_mode() -> void:
	color = NIGHTVISION
	$AudioStreamPlayer2D.stream = load("res://SFX/nightvision.wav")
	$AudioStreamPlayer2D.play()
#	alternar_luzes(true)


func _on_Timer_timeout() -> void:
	cooldown = false
#	NIGHTVISION_mode()
	pass # Replace with function body.
#
#func alternar_luzes(cameras_ligadas: bool) -> void:
#	get_tree().call_group("Cameras", "set", "enabled", cameras_ligadas)
#	get_tree().call_group("Lanternas", "set", "enabled", not cameras_ligadas)
