extends Area2D


func _on_body_entered(body):
	body = body as Player
	
	body.take_damage()
