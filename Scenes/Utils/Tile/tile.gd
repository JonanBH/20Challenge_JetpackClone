extends StaticBody2D
class_name Tile

func get_tile_size() -> float:
	var size = 720
	
	size = $Sprite2D.texture.get_width()
	
	return size
