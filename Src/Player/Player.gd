extends RigidBody2D

class_name Player

#legs nodes
onready var RightHip = $HipR#$Chest/HipR
onready var LeftHip = $HipL#$Chest/HipL
onready var RightLeg = $LegR#$Chest/LegR
onready var LeftLeg = $LegL#$Chest/LegL

#hand nodes
onready var RightHand = $HandR#$Chest/HandR
onready var LeftHand = $HandL#$Chest/HandL

#body node
onready var Body = $Butt/Chest
onready var Butt = $Butt
#onready var Head = 

#stats
const RotSpeed = 4
const Max_Angle = -200
const Razgib = 250

#debug
onready var deb = 0


func _physics_process(delta):
	get_input()
	bouncing()
	get_normalized()
	razgibanie(Butt,RightHip)
	razgibanie(Butt,LeftHip)
	razgibanie(Body,RightHip)
	razgibanie(Body,LeftHip)
	razgibanie_body(Body,Butt)
	#razgibanie(RightHip,RightLeg)
	#razgibanie(LeftHip,LeftLeg)
	
	
	
func get_input():
	if Input.is_action_pressed("right") and (RightHip.rotation_degrees > Max_Angle):
		RightHip.rotation_degrees-=RotSpeed
		deb = RightHip.rotation_degrees-RightLeg.rotation_degrees
	if Input.is_action_pressed("left") and (RightHip.rotation_degrees > Max_Angle):
		LeftHip.rotation_degrees-=RotSpeed
	if Input.is_action_pressed("stabilisation_right"):
		#RightHand.rotation+=RotSpeed
		Body.rotation_degrees+=RotSpeed
	if Input.is_action_pressed("stabilisation_left"):
		#LeftHand.rotation-=RotSpeed
		Body.rotation_degrees-=RotSpeed

func get_normalized():
	#if not (Input.is_action_pressed("right")):
		#if RightHip.rotation>0:
			#RightHip.rotation-=RotSpeed
	#if not (Input.is_action_pressed("left")):
		#if LeftHip.rotation<0:
			#LeftHip.rotation+=RotSpeed
	if RightHip.rotation_degrees-RightLeg.rotation_degrees>0 and RightHip.rotation_degrees-RightLeg.rotation_degrees<100:
		RightLeg.rotation_degrees=RightHip.rotation_degrees
	if LeftHip.rotation_degrees-LeftLeg.rotation_degrees>0 and LeftHip.rotation_degrees-LeftLeg.rotation_degrees<100: 
		LeftLeg.rotation_degrees=LeftHip.rotation_degrees
	
	
func bouncing():
	pass
	
func razgibanie(target,from):
	target.add_central_force(Vector2(0,(Razgib*(tan(target.rotation_degrees+from.rotation_degrees)))))
	correct_razgib(target)
	
func razgibanie_body(target,from):
	target.add_central_force(Vector2(0,(Razgib*(sin(target.rotation_degrees+from.rotation_degrees)))))
	correct_razgib(target)

func correct_razgib(target):
	if target.applied_force<Vector2(0,0):
		target.applied_force=Vector2(0,0)
	if target.applied_force>Vector2(0,-Razgib):
		target.applied_force=Vector2(0,-Razgib)

func _ready():
	pass # Replace with function body.


