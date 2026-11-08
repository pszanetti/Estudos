extends CanvasModulate

const DARK: Color = Color("ffffff") 
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
	
	
func NIGHTVISION_mode() -> void:
	color = NIGHTVISION
	$AudioStreamPlayer2D.stream = load("res://SFX/nightvision.wav")
	$AudioStreamPlayer2D.play()


func _on_Timer_timeout() -> void:
	cooldown = false
	pass # Replace with function body.
