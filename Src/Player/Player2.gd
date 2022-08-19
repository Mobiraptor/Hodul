extends RigidBody2D

class_name Player2

#legs nodes
onready var RightHip = $HipR#$Chest/HipR
onready var LeftHip = $HipL#$Chest/HipL
onready var RightLeg = $LegR#$Chest/LegR
onready var LeftLeg = $LegL#$Chest/LegL

#hand nodes
onready var RightHand = $HandR#$Chest/HandR
onready var LeftHand = $HandL#$Chest/HandL

#body node
onready var Body = $Chest
#onready var Butt = $Butt
onready var Head = get_node(".")

#stats
const Stab_Speed = 10
const Stab_Speed_y = 5
const RotSpeed = 4
const Max_Angle = -200
const Razgib = -600

#debug
onready var deb = 0


func _physics_process(delta):
	get_input()
	bouncing()
	get_normalized()
	razgibanie(Body,RightHip)
	razgibanie(Body,LeftHip)
	#razgibanie(RightHip,RightLeg)
	#razgibanie(LeftHip,LeftLeg)
	
	
	
func get_input():
	if Input.is_action_pressed("right") and (Body.rotation_degrees-RightHip.rotation_degrees<130):
		RightHip.rotation_degrees-=RotSpeed
		deb = abs(RightHip.rotation_degrees)/180
		pass
	if Input.is_action_pressed("left") and (Body.rotation_degrees-LeftHip.rotation_degrees<180):
		LeftHip.rotation_degrees-=RotSpeed
	if Input.is_action_pressed("stabilisation_right"):
		Head.apply_impulse(Vector2(0,0),Vector2(Stab_Speed,0))
	if Input.is_action_pressed("stabilisation_left"):
		Head.apply_impulse(Vector2(0,0),Vector2(-Stab_Speed,0))
	if Input.is_action_pressed("muscles_up"):
		Head.apply_impulse(Vector2(0,0),Vector2(0,-Stab_Speed_y))
	if Input.is_action_pressed("muscles_down"):
		Head.apply_impulse(Vector2(0,0),Vector2(0,Stab_Speed_y))
	pass

func get_normalized():
	if RightHip.rotation_degrees-RightLeg.rotation_degrees>0 and RightHip.rotation_degrees-RightLeg.rotation_degrees<100:
		RightLeg.rotation_degrees=RightHip.rotation_degrees
	if LeftHip.rotation_degrees-LeftLeg.rotation_degrees>0 and LeftHip.rotation_degrees-LeftLeg.rotation_degrees<100: 
		LeftLeg.rotation_degrees=LeftHip.rotation_degrees
	
	
func bouncing():
	pass
	
		
func razgibanie(target,from):
	target.add_central_force(Vector2(0,(Razgib*(abs(from.rotation_degrees)/180)))) #(tan(target.rotation_degrees+from.rotation_degrees)))))
	correct_razgib(target)
	

func correct_razgib(target):
	if target.applied_force>Vector2(0,0):
		target.applied_force=Vector2(0,0)
	if target.applied_force<Vector2(0,Razgib):
		target.applied_force=Vector2(0,Razgib)

func _ready():
	LeftLeg.set_bounce(0)
	RightLeg.set_bounce(0)



