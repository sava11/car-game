extends CharacterBody2D
@export var size_y:Vector2=Vector2(0,22)
@export var rot_offset:Vector2
@onready var size=Vector2($c.shape.radius,$c.shape.height)
func get_ang_move(angle:float,ex:float):
	var ang1=abs(ex)
	var le=int(360/ang1)
	var ang=int(abs(angle))%360
	for e in range(0,le):
		if ang>=e*ang1 and ang<(e+1)*ang1:
			return e
	return -1
var cur_rot:float=0
func _physics_process(delta):
	var vec:int=Input.get_action_strength("ui_left")-Input.get_action_strength("ui_right")
	cur_rot+=2*vec
	$sp.frame=get_ang_move(cur_rot,7.5)
	$sp.offset=fnc.move(cur_rot)*rot_offset
	$c.rotation_degrees=$sp.frame*7.5+90
	$c.position=$sp.offset+Vector2(0,6)
	$c.shape.height=size.y-abs(sin(deg_to_rad(cur_rot)))*size_y.y
	$c.shape.radius=size.x-abs(cos(deg_to_rad(cur_rot)))*size_y.x
