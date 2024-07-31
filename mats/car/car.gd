class_name car extends RigidBody2D
@export_range(0,999,0.001,"or_greater","suffix:px/s") var speed_max:float=100
@export_range(0,999,0.001,"or_greater","suffix:px/s") var acceleration:float=10
@export_range(0,999,0.001,"or_greater","suffix:px/s") var deceleration:float=10
@export_range(0,999,0.001,"or_greater","suffix:deg/s") var rotation_degrees_speeed:float=10
@export_range(-180,180,0.001,"or_greater","suffix:deg/s") var rotation_degrees_offset:float=90

var gravity:float=98
var current_speed:float=0
var input_vector:=Vector2.ZERO
var cur_rot:float=0
# преобразует вектор в угол
func vec_to_deg(vec:Vector2)->float:
	return snapped((180/PI)*-atan2(-vec.y,vec.x),0.000001)
# преобразует угол в вектор
func deg_to_vec(deg:float)->Vector2:
	return Vector2(cos(deg_to_rad(deg)),sin(deg_to_rad(deg)))
func _ready():
	print(vec_to_deg(Vector2(1,1)))
func _integrate_forces(st:PhysicsDirectBodyState2D):
	var step:=st.get_step()
	# физика сопрекоснавений
	for contact_index in range(st.get_contact_count()):
		#var collision_normal = st.get_contact_local_normal(contact_index)
		st.apply_impulse(st.get_contact_impulse(contact_index),st.get_contact_local_position(contact_index))
		
	movement(step)
	cur_rot+=input_vector.x*step*rotation_degrees_speeed
	
	if input_vector.y!=0:
		var global_dir:=deg_to_vec(90*input_vector.y+cur_rot+rotation_degrees+rotation_degrees_offset)
		st.apply_impulse(speed_max*global_dir)
	print(cur_rot)
	##rotate(vec_to_deg(dir*speed_max*input_vector+pos)-rotation_degrees+90)
	#global_vel+=deg_to_vec(rotation_degrees+90)*input_vector.y*speed_max*step*gravity
	var global_vel=st.get_linear_velocity()
	global_vel=global_vel.move_toward(Vector2.ZERO,gravity*step)
	angular_velocity=0#move_toward(angular_velocity,0,gravity*step)
	st.set_linear_velocity(global_vel)
# функция для управления движением
# двигаться может как игрок так и неигровые персонажи(машинки)
func movement(step:float):
	
	# игрок
	input_vector=Vector2(
		Input.get_action_strength("right")-Input.get_action_strength("left"),
		Input.get_action_strength("down")-Input.get_action_strength("up")
	)
	pass
