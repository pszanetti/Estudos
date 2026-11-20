extends Area2D

func _on_Briefcase_body_entered(body: Node) -> void:
	body.collect_briefcase()
	queue_free()
	pass # Replace with function body.
