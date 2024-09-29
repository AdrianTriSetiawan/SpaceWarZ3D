extends TouchScreenButton

# Called when the node enters the scene tree for the first time.
func _ready():
	pass  # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass

func _on_TouchScreenButton2_pressed():
	var menu_scene_path = "res://menu.tscn"
	get_tree().change_scene(menu_scene_path)
