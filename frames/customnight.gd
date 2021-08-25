extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var params
var modes
var cmode
func _ready():
	cmode = 0
	modes = [
		"Падлы мохнатые:20 20 0 0 0 0 0",
		"Черти позорные:0 0 20 20 20 0 0",
		"Государствен\nные работники:0 0 0 20 20 0 0",
		"ПНСМ 3:20 20 20 0 0 20 20",
		"Где-то в метро:20 20 0 0 20 0 0",
		"Майдан:5 5 5 10 20 5 10",
		"Лишние квадратные метры:5 5 5 55 5 5 5",
		"Где деньги взять?:8 800 5 5 5 35 35",
		"Спокойной ночи:1 2 3 4 5 6 7",
		"Будь настороже:10 10 10 10 10 10 10",
		"Удачи.:15 15 15 15 15 15 15",
		"F:20 20 20 20 20 20 20",
		"Коты, успокойтесь:999 999 0 0 0 0 0",
		"?!:999 999 999 999 999 999 999",
		"Валерьянка (-100 у котов):-100 -100 0 0 0 0 0",
		"Я дневник дома забыл:0 0 12 0 0 34 56",
	]
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
	
	if Input.is_action_pressed("ui_end") or (params.maxAI == 19 and params.milkAI == 9 and params.titanAI == 0 and params.sbuAI == 19 and params.gopAI == 10 and params.lentolnAI == 0 and params.swetlanAI == 0): # "Пароль в формате ММТСГЕС - 19/9/0/19/10/0/0",
		print("Night 8")
		$"/root/GlobalParameters".night = 8
		params.gopAI = 0
		params.swetlanAI = 0
		params.lentolnAI = 0
		params.sbuAI = 0
		params.milkAI = 0
		params.maxAI = 0
		params.titanAI = 0
		params.olgaAI = 20
	else:
		$"/root/GlobalParameters".night = 7
	get_tree().change_scene("res://frames/nightCOunt.tscn")


func _on_HarderMax_pressed():
	if params.maxAI < 20:
		params.maxAI += 1
		$BG_customnight/Max2/Max/Difficulty.text = str(params.maxAI)


func _on_EasierMax_pressed():
	if params.maxAI > 0:
		params.maxAI -= 1
		$BG_customnight/Max2/Max/Difficulty.text = str(params.maxAI)


func _on_HarderMil_pressed():
	if params.milkAI < 20:
		params.milkAI += 1
		$BG_customnight/Milka2/Milka/Node2D/Difficulty.text = str(params.milkAI)


func _on_EasierMil_pressed():
	if params.milkAI > 0:
		params.milkAI -= 1
		$BG_customnight/Milka2/Milka/Node2D/Difficulty.text = str(params.milkAI)


func _on_HarderTit_pressed():
	if params.titanAI < 20:
		params.titanAI += 1
		$BG_customnight/Wannadwatitana2/Wannadwatitana/Node2D/Difficulty.text = str(params.titanAI)


func _on_EasierTit_pressed():
	if params.titanAI > 0:
		params.titanAI -= 1
		$BG_customnight/Wannadwatitana2/Wannadwatitana/Node2D/Difficulty.text = str(params.titanAI)


func _on_HarderSbu_pressed():
	if params.sbuAI < 20:
		params.sbuAI += 1
		$BG_customnight/SBU2/SBU/Node2D/Difficulty.text = str(params.sbuAI)


func _on_EasierSbu_pressed():
	if params.sbuAI > 0:
		params.sbuAI -= 1
		$BG_customnight/SBU2/SBU/Node2D/Difficulty.text = str(params.sbuAI)


func _on_HarderMasya_pressed():
	if params.gopAI < 20:
		params.gopAI += 1
		$BG_customnight/Masya2/Masya/Node2D/Difficulty.text = str(params.gopAI)


func _on_EasierMasya_pressed():
	if params.gopAI > 0:
		params.gopAI -= 1
		$BG_customnight/Masya2/Masya/Node2D/Difficulty.text = str(params.gopAI)


func _on_HarderLen_pressed():
	if params.lentolnAI < 20:
		params.lentolnAI += 1
		$BG_customnight/Lentoln2/Lentoln/Node2D/Difficulty.text = str(params.lentolnAI)


func _on_EasierLen_pressed():
	if params.lentolnAI > 0:
		params.lentolnAI -= 1
		$BG_customnight/Lentoln2/Lentoln/Node2D/Difficulty.text = str(params.lentolnAI)


func _on_HarderSwe_pressed():
	if params.swetlanAI < 20:
		params.swetlanAI += 1
		$BG_customnight/Swetlan2/Swetlan/Node2D/Difficulty.text = str(params.swetlanAI)


func _on_EasierSwe_pressed():
	if params.swetlanAI > 0:
		params.swetlanAI -= 1
		$BG_customnight/Swetlan2/Swetlan/Node2D/Difficulty.text = str(params.swetlanAI)


#func _on_ButtonF_pressed():


func switch_modes():
	$BG_customnight/Label.text = modes[cmode].split(":")[0]
	$BG_customnight/Swetlan2/Swetlan/Node2D/Difficulty.text = modes[cmode].split(":")[1].split(" ")[6]
	$BG_customnight/Masya2/Masya/Node2D/Difficulty.text = modes[cmode].split(":")[1].split(" ")[4]
	$BG_customnight/Lentoln2/Lentoln/Node2D/Difficulty.text = modes[cmode].split(":")[1].split(" ")[5]
	$BG_customnight/SBU2/SBU/Node2D/Difficulty.text = modes[cmode].split(":")[1].split(" ")[3]
	$BG_customnight/Wannadwatitana2/Wannadwatitana/Node2D/Difficulty.text = modes[cmode].split(":")[1].split(" ")[2]
	$BG_customnight/Milka2/Milka/Node2D/Difficulty.text = modes[cmode].split(":")[1].split(" ")[1]
	$BG_customnight/Max2/Max/Difficulty.text = modes[cmode].split(":")[1].split(" ")[0]
	params.gopAI = int(modes[cmode].split(":")[1].split(" ")[4])
	params.swetlanAI = int(modes[cmode].split(":")[1].split(" ")[6])
	params.lentolnAI = int(modes[cmode].split(":")[1].split(" ")[5])
	params.sbuAI = int(modes[cmode].split(":")[1].split(" ")[3])
	params.milkAI = int(modes[cmode].split(":")[1].split(" ")[1])
	params.maxAI = int(modes[cmode].split(":")[1].split(" ")[0])
	params.titanAI = int(modes[cmode].split(":")[1].split(" ")[2])

func _on_PrevMode_pressed():
	if cmode > 0:
		cmode-=1
	switch_modes()


func _on_NextMode_pressed():
	if cmode < modes.size()-1:
		cmode+=1
	switch_modes()
