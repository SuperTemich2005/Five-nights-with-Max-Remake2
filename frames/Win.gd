extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var save_file
var params
# Called when the node enters the scene tree for the first time.
func _ready():
	params = get_node("/root/GlobalParameters")
	save_file = ConfigFile.new()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_remove5_timeout():
	$Label.text = "  часов"
	

func _on_draw6_timeout():
	$Label.text = "6 часов"


func _on_return_timeout(): # выдаем звездочки
	save_file.load("C:/Games/fnwmr.save")
	if params.night == 5:
		save_file.set_value("Stars","Comp5",1)
		save_file.set_value("General","Night",params.night+1)
		get_tree().change_scene("res://frames/ending1.tscn")
	elif params.night == 7 and params.lentolnAI == 20 and params.maxAI == 20 and params.milkAI == 20 and params.titanAI == 20 and params.swetlanAI == 20 and params.gopAI == 20 and params.sbuAI == 20:
		save_file.set_value("Stars","All20",1)
		get_tree().change_scene("res://frames/test.tscn")
	elif params.night == 6:
		save_file.set_value("Stars","Comp6",1)
		get_tree().change_scene("res://frames/test.tscn")
	elif params.night == 8:
		save_file.set_value("Stars","BossDown",1)
		get_tree().change_scene("res://frames/ending2.tscn")
	else:
		save_file.set_value("General","Night",params.night+1)
		get_tree().change_scene("res://frames/test.tscn")
	save_file.save("C:/Games/fnwmr.save")
	
