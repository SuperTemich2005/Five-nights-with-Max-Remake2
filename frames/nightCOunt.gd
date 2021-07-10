extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var night = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = "Ночь "+str(night)


func _on_NextFrame_timeout():
	get_tree().change_scene("res://frames/Night.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



