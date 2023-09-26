extends Node2D

@export var points_per_step = 1

var score : int = 0

@onready var level_manager := $LevelManager


func _ready():
	level_manager.steps_moved.connect(_on_steps_moved)


func _on_steps_moved(amount : int):
	score += amount
	
	print(score)
