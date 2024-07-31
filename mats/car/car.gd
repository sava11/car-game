class_name car extends RigidBody2D
@export_range(0,999,0.001,"or_greater","suffix:px/s") var speed_max:float=100
@export_range(0,999,0.001,"or_greater","suffix:px/s") var acceleration:float=10
@export_range(0,999,0.001,"or_greater","suffix:px/s") var deceleration:float=10
@export_range(0,999,0.001,"or_greater","suffix:deg/s") var max_rotation_degrees:float=30
@export_range(0,999,0.001,"or_greater","suffix:deg/s") var rotation_degrees_speeed:float=10
@export_range(0,999,0.001,"or_greater","suffix:deg/s") var rotation_degrees_offset:float=90
@export var wheels:Array[wheel_data]
var gravity:float=980
var current_speed:float=0
var input_vector:=Vector2.ZERO
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
	var dir=Vector2.ZERO
	var pos=Vector2.ZERO
	for wheel in wheels:
		if wheel.can_ratate:
			wheel.direction=deg_to_vec(max_rotation_degrees*input_vector.x)
			pass
			#wheel.direction=deg_to_vec(move_toward(vec_to_deg(wheel.direction)+rotation_degrees-rotation_degrees_offset,max_rotation_degrees*input_vector.x,rotation_degrees_speeed*step))
			
		dir+=wheel.direction/float(wheels.size())
		pos+=wheel.position/float(wheels.size())
	print(linear_velocity," ",dir," ",pos," ",vec_to_deg(dir)," ",Input.get_gravity())
	
	if input_vector.y!=0:
		var global_dir:=deg_to_vec(vec_to_deg(input_vector)+rotation_degrees-rotation_degrees_offset+vec_to_deg(dir))
		st.apply_impulse(
		speed_max*global_dir,
		deg_to_vec(vec_to_deg(pos)-rotation_degrees-rotation_degrees_offset)
		)
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
