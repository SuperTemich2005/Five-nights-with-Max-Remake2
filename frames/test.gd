extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var save_file
var extra_on
var curstar

# Called when the node enters the scene tree for the first time.
func _ready():
	curstar = 0
	extra_on = 0
	save_file = ConfigFile.new()
	if save_file.load("C:/Games/fnwmr.save") == OK:
		$"Load Game".text = "Ночь "+str(save_file.get_value("General","Night"))
		if save_file.get_value("Stars","Comp5",0) == 1:
			$CompNight5.visible = true
		if save_file.get_value("Stars","Comp6",0) == 1:
			$CompNight6.visible = true
		if save_file.get_value("Stars","BossDown",0) == 1:
			$CompNight8.visible = true
		if save_file.get_value("Stars","All20",0) == 1:
			$CompNightAll20.visible = true
	else:
		$"Load Game".hide()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_New_Game_pressed():
	get_tree().change_scene("res://frames/Intro.tscn")
	var params = get_node("/root/GlobalParameters")
	save_file.erase_section("General")
	save_file.erase_section("Stars")
	save_file.set_value("General","Night",1)
	save_file.save("C:/Games/fnwmr.save")
	params.night = 1
	params.maxAI = 0
	params.milkAI = 0


func _on_Load_Game_pressed():
	var params = get_node("/root/GlobalParameters")
	save_file.load("C:/Games/fnwmr.save")
	params.night = save_file.get_value("General","Night",1)
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
	
	get_tree().change_scene("res://frames/nightCOunt.tscn")


func _on_Extras_pressed():
	extra_on = abs(1-extra_on)
	$Instructions.visible = bool(extra_on)
	$"Custom Night".visible = bool(extra_on)
	$Credits.visible = bool(extra_on)
	$Max.visible = bool(abs(1-extra_on))


func _on_CustomNight_pressed():
	get_tree().change_scene("res://frames/customnight.tscn")


func _on_Credits_pressed():
	get_tree().change_scene("res://frames/credits.tscn")


func _on_Instructions_pressed():
	get_tree().change_scene("res://frames/instructions.tscn")


func _on_flicker_timeout():
	curstar = abs(1-curstar)
	$CompNight5/StarColor.visible = bool(curstar)
	$CompNight6/StarColor.visible = bool(curstar)
	$CompNight8/StarColor.visible = bool(curstar)
	$CompNightAll20/StarColor.visible = bool(curstar)
	$CompNightAll20/StarColor.color = Color(randf(),randf(),randf())
