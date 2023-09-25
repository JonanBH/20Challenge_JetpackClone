extends Node2D

@export var speed : float = 50
@export var warmup_tiles : int = 5
@export var tile_possibilities : Array[PackedScene]
@export var hazard_possibilities : Array[PackedScene]

var last_tile = null


func _ready():
	for i in range(0, warmup_tiles):
		_spawn_random_tile()

func _process(delta):
	for tile in $Tiles.get_children():
		tile.position += Vector2.LEFT * speed * delta
		
		if tile.position.x <= -1100 :
			tile.queue_free()
			_spawn_random_tile()


func _spawn_random_tile():
	last_tile = _spawn_tile(tile_possibilities.pick_random())


func _spawn_tile(tile):
	position = Vector2(0, 0)
	
	if last_tile != null:
		position.x = last_tile.position.x + 1080
	
	var new_tile = tile.instantiate()
	
	$Tiles.add_child(new_tile)
	new_tile.position = position
	
	return new_tile


