extends Marker2D
# скорость вращения колеса
@export_range(0,999,0.001,"or_greater","suffix:px/s") var current_speed:float=0
func get_move_dir()->Vector2:
	return Vector2(cos(deg_to_rad(rotation_degrees)),sin(deg_to_rad(rotation_degrees)))*current_speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#rotation_degrees=move_toward(rotation_degrees,rotation_dir*max_rotation_degrees,rotation_degrees_speeed*delta)
