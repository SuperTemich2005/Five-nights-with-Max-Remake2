extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
# Called when the node enters the scene tree for the first time.
func _ready():
	var params = get_node("/root/GlobalParameters")
	if params.night != 8:
		$Label.text = "Ночь "+str(params.night)
	else:
		$Label.text = "Смертельная схватка"


func _on_NextFrame_timeout():
	get_tree().change_scene("res://frames/Night.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



