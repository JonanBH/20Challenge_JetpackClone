extends RigidBody2D
class_name Player

signal took_damage

@export var upwards_force : float = 30
@export var max_speed : float = 500

var is_applying_force : bool = false
var is_alive : bool = true

func _process(delta):
	if not is_alive :
		return
		
	if is_applying_force:
		linear_velocity += Vector2.UP * upwards_force * delta
	print(is_applying_force)


func _physics_process(_delta):
	linear_velocity.y = clamp(linear_velocity.y, -max_speed, max_speed)


func _unhandled_input(event):
	if event is InputEventKey:
		var key_event := event as InputEventKey
		
		if key_event.is_action_pressed("upwards_force") :
			is_applying_force = true
		if key_event.is_action_released("upwards_force"):
			is_applying_force = false
			
		get_viewport().set_input_as_handled()
	
	if event is InputEventMouseButton:
		if event.button_index == 0 and event.pressed :
			is_applying_force = true
		if event.button_index == 0 and not event.pressed:
			is_applying_force = false


func take_damage():
	took_damage.emit()
	is_alive = false
	
	print("Player defeated")
