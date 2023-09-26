extends Node2D

signal steps_moved(steps : int)

@export var speed : float = 50
@export var max_speed : float = 1000
@export var acceleration : float = 20
@export var speed_up_delay : float = 5
@export var warmup_tiles : int = 5
@export var step_distance : int = 50
@export var tile_possibilities : Array[PackedScene]
@export var hazard_possibilities : Array[PackedScene]

var last_tile = null
var moved_step : float = 0
@onready var current_speed : float = speed

func _ready():
	for i in range(0, warmup_tiles):
		_spawn_random_tile()
	$SpeedUpTimer.wait_time = speed_up_delay
	$SpeedUpTimer.start()
	

func _process(delta):
	var step : float = current_speed * delta
	for tile in $Tiles.get_children():
		tile.position += Vector2.LEFT * step
		
		if tile.position.x <= -1100 :
			tile.queue_free()
			
	if $Tiles.get_child_count() < warmup_tiles:
		_spawn_random_tile()
	
	moved_step += step
	var steps_count : float = ((int)(moved_step) / step_distance)
	moved_step -= steps_count * step_distance
	
	if steps_count > 0:
		steps_moved.emit(steps_count)

func _spawn_random_tile():
	last_tile = _spawn_tile(tile_possibilities.pick_random())


func _spawn_tile(tile):
	var _position : Vector2 = Vector2(0, 0)
	var new_tile = tile.instantiate()
	
	
	if last_tile != null:
		_position.x = last_tile.position.x + last_tile.get_tile_size()
	
	$Tiles.add_child(new_tile)
	new_tile.position = _position
	
	return new_tile




func _on_speed_up_timer_timeout():
	current_speed = clamp(current_speed + acceleration, speed, max_speed)
