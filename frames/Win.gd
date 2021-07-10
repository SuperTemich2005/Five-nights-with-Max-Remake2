extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var save_file
var params
# Called when the node enters the scene tree for the first time.
func _ready():
	params = get_node("/root/GlobalParameters")
	save_file = File.new()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_remove5_timeout():
	$Label.text = "  часов"


func _on_draw6_timeout():
	$Label.text = "6 часов"
	if params.night < 6:
		save_file.open("C:/Games/fnwmr.save",File.WRITE)
		save_file.store_string("night "+str(params.night+1))
	


func _on_return_timeout():
	get_tree().change_scene("res://frames/test.tscn")
