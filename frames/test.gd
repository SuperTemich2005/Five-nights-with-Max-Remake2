extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var save_file


# Called when the node enters the scene tree for the first time.
func _ready():
	save_file = File.new()
	if not save_file.file_exists("C:/Games/fnwmr.save"):
		$"Load Game".hide()
	else:
		save_file.open("C:/Games/fnwmr.save", File.READ)
		$"Load Game".text = "Ночь "+save_file.get_as_text().split(" ")[-1]
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_New_Game_pressed():
	get_tree().change_scene("res://frames/Intro.tscn")
	var params = get_node("/root/GlobalParameters")
	save_file.open("C:/Games/fnwmr.save", File.WRITE)
	save_file.store_string("night 1")
	params.night = 1
	params.maxAI = 0
	params.milkAI = 0


func _on_Load_Game_pressed():
	var params = get_node("/root/GlobalParameters")
	save_file.open("C:/Games/fnwmr.save", File.READ)
	params.night = int(save_file.get_as_text().split(" ")[-1])
	if params.night == 1:
		params.maxAI = 0
		params.milkAI = 0
		params.swetlanAI = -4
		params.gopAI = -4
		params.titanAI = -4
		params.sbuAI = -4
		params.lentolnAI = -4
		params.olgaAI = -4
	if params.night == 2:
		params.maxAI = 2
		params.milkAI = 2
		params.swetlanAI = -4
		params.gopAI = -2
		params.titanAI = -2
		params.sbuAI = -4
		params.lentolnAI = -4
		params.olgaAI = -4
	if params.night == 3:
		params.maxAI = 6
		params.milkAI = 6
		params.swetlanAI = -2
		params.gopAI = 2
		params.titanAI = 2
		params.sbuAI = -4
		params.lentolnAI = 0
		params.olgaAI = -4
	if params.night == 4:
		params.maxAI = 6
		params.milkAI = 6
		params.swetlanAI = 2
		params.gopAI = 4
		params.titanAI = 4
		params.sbuAI = 2
		params.lentolnAI = 4
		params.olgaAI = -4
	if params.night == 5:
		params.maxAI = 10
		params.milkAI = 10
		params.swetlanAI = 10
		params.gopAI = 10
		params.titanAI = 10
		params.sbuAI = 10
		params.lentolnAI = 10
		params.olgaAI = -4
	if params.night == 6:
		params.maxAI = 12
		params.milkAI = 12
		params.swetlanAI = 12
		params.gopAI = 12
		params.titanAI = 12
		params.sbuAI = 12
		params.lentolnAI = 12
		params.olgaAI = -4
	
	get_tree().change_scene("res://frames/Night.tscn")


func _on_Extras_pressed():
	get_tree().change_scene("res://frames/customnight.tscn")
