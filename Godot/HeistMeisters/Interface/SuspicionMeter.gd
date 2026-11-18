extends TextureProgress


export var suspicion_multiplier = 2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	value = 0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	value -= step
	pass

func player_seen() -> void:
	value += step * suspicion_multiplier 
	if value == max_value:
		end_game()
		
func end_game():
	get_tree().quit()
	pass
	
	
