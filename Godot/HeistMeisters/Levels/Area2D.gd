extends Area2D

func _ready() -> void:
	hide()
	pass
	




func _on_Area2D_body_entered(body: Node) -> void:
	if body.has_node("Briefcase"):
		get_tree().quit()

