extends Area2D

export var card: String = "Blue"


func _on_AcessCard_body_entered(body: Node) -> void:
	body.create_card(card)
	queue_free()
