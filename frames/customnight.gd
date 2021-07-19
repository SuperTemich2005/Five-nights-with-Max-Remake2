extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var params
func _ready():
	params = get_node("/root/GlobalParameters")
	params.night = 7
	params.maxAI = 0
	params.milkAI = 0
	params.titanAI = 0
	params.lentolnAI = 0
	params.swetlanAI = 0
	params.gopAI = 0
	params.sbuAI = 0
	params.olgaAI = -99



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Back_pressed():
	get_tree().change_scene("res://frames/test.tscn")


func _on_Start_pressed():
	get_tree().change_scene("res://frames/nightCOunt.tscn")
	$"/root/GlobalParameters".night = 7


func _on_HarderMax_pressed():
	if params.maxAI < 20:
		params.maxAI += 1
		$BG/Max2/Max/Difficulty.text = str(params.maxAI)


func _on_EasierMax_pressed():
	if params.maxAI > 0:
		params.maxAI -= 1
		$BG/Max2/Max/Difficulty.text = str(params.maxAI)


func _on_HarderMil_pressed():
	if params.milkAI < 20:
		params.milkAI += 1
		$BG/Milka2/Milka/Node2D/Difficulty.text = str(params.milkAI)


func _on_EasierMil_pressed():
	if params.milkAI > 0:
		params.milkAI -= 1
		$BG/Milka2/Milka/Node2D/Difficulty.text = str(params.milkAI)


func _on_HarderTit_pressed():
	if params.titanAI < 20:
		params.titanAI += 1
		$BG/Wannadwatitana2/Wannadwatitana/Node2D/Difficulty.text = str(params.titanAI)


func _on_EasierTit_pressed():
	if params.titanAI > 0:
		params.titanAI -= 1
		$BG/Wannadwatitana2/Wannadwatitana/Node2D/Difficulty.text = str(params.titanAI)


func _on_HarderSbu_pressed():
	if params.sbuAI < 20:
		params.sbuAI += 1
		$BG/SBU2/SBU/Node2D/Difficulty.text = str(params.sbuAI)


func _on_EasierSbu_pressed():
	if params.sbuAI > 0:
		params.sbuAI -= 1
		$BG/SBU2/SBU/Node2D/Difficulty.text = str(params.sbuAI)


func _on_HarderMasya_pressed():
	if params.gopAI < 20:
		params.gopAI += 1
		$BG/Masya2/Masya/Node2D/Difficulty.text = str(params.gopAI)


func _on_EasierMasya_pressed():
	if params.gopAI > 0:
		params.gopAI -= 1
		$BG/Masya2/Masya/Node2D/Difficulty.text = str(params.gopAI)


func _on_HarderLen_pressed():
	if params.lentolnAI < 20:
		params.lentolnAI += 1
		$BG/Lentoln2/Lentoln/Node2D/Difficulty.text = str(params.lentolnAI)


func _on_EasierLen_pressed():
	if params.lentolnAI > 0:
		params.lentolnAI -= 1
		$BG/Lentoln2/Lentoln/Node2D/Difficulty.text = str(params.lentolnAI)
