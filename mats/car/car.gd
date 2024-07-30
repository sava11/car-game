extends RigidBody2D
@export_range(0,999,0.001,"or_greater","suffix:px/s") var speed_max:float=100
@export_range(0,999,0.001,"or_greater","suffix:px/s") var acceleration:float=10
@export_range(0,999,0.001,"or_greater","suffix:px/s") var deceleration:float=10
@export_range(0,999,0.001,"or_greater","suffix:deg/s") var rotation_degrees_speeed:float=10

func _integrate_forces(state:PhysicsDirectBodyState2D):
	var step:=state.get_step()
	
