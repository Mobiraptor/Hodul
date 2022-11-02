extends Button


onready var Scene = $"."

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		_on_Restart_pressed()

func _on_Restart_pressed():
	Scene.get_tree().reload_current_scene()
