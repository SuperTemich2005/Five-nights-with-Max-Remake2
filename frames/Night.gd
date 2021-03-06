extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#var camVel
var camSpeed
var cameraVelocity
var maskOn 
var camOn
var crouchOn
var doorOn
var turnOn
var curCam
var camNames
var time
var night
var charge
var maxPos
var milkPos
var titanPos
var lentolnPos
var swetlanPos
var gopPos
var sbuPos
var olgaPos
var maxAI
var milkAI
var titanAI
var lentolnAI
var swetlanAI
var gopAI
var sbuAI
var olgaAI
var AudioWhere
var SwetlanIntCount
var rngesus = RandomNumberGenerator.new()

func _ready():
	var params = get_node("/root/GlobalParameters")
	# Time
	time = 0
	night = params.night
	
	$CamParent/Night.text = str(night)+" ночь"
	if night == 8:
		$Ambient.set_stream(load("res://sounds/bossfight.ogg"))
	charge = 20
	# Cam
	camSpeed = 15
	curCam = 0
	cameraVelocity = Vector2()
	# ONs
	maskOn = 0
	camOn = 0
	turnOn = 0
	crouchOn = 0
	doorOn = 0
	# POSes
	maxPos = 0
	milkPos = 0
	titanPos = 0
	lentolnPos = 0
	swetlanPos = 0
	SwetlanIntCount = 0
	gopPos = 0
	sbuPos = 0
	olgaPos = 0
	# AIs
	if night == null:
		maxAI = 0
		milkAI = 0
		titanAI = 0
		lentolnAI = 0
		swetlanAI = 0
		gopAI = 0
		sbuAI = 0
		olgaAI = 0
	else:
		maxAI = params.maxAI
		milkAI = params.milkAI
		titanAI = params.titanAI
		lentolnAI = params.lentolnAI
		swetlanAI = params.swetlanAI
		gopAI = params.gopAI
		sbuAI = params.sbuAI
		olgaAI = params.olgaAI
	camNames = [
		"",
		"Комната родителей",
		"Комната Тёмыча",
		"Коридор",
		"Балкон",
		"Входная дверь",
		"Кухня",
	]
	if maxAI == 999:
		$MoveClk.wait_time = 3
		$CamParent/CamItself/MapBg/Generator/Discharge.wait_time = 10
	if maxAI < 0:
		maxAI = 20
		milkAI = 20
	$CamParent/MaskItself.hide() # hiding mask
	$CamParent/CamItself.hide() # hiding tablet
	$CamParent/CrouchItself.hide() # hiding floor
	$CamParent/CamItself/CamVP/Max.hide() # hiding Max
	$CamParent/CamItself/CamVP/Milka.hide() # hiding Milka
	$CamParent/CamItself/CamVP/Masya.hide() # hiding gopnik
	$BG/MaxInOffice.hide()
	$BG/MilkaInOffice.hide()
	$CamParent/JumpScare.hide()
	$CamParent/CamItself/MapBg/Generator.hide()
	$CamParent/GenAlert.play()
	$Ambient.play()
	$CamParent/WindowBG.hide()
	$DoorItself.hide()
	if night != null and night < 7:
		$PhoneCall1.set_stream(load("res://sounds/phonecall"+str(night)+".ogg"))
	else:
		$PhoneCall1.remove_and_skip()
		print("No phone call for night "+str(night))
	#$Aasd.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#camVel = get_global_mouse_position().x-OS.window_size.x/2
	#$CamParent.position.x = clamp(camVel,0,1024)
	if titanPos >= 5 and crouchOn == 1:
		titanPos = 0
		$DIEBITCH3.stop()
	if olgaPos == 7 and crouchOn == 1 and olgaAI > 0:
		$DIEBITCH3.stop()
		print("Moving Olga to door")
		olgaPos = 8
		_on_MoveClk_timeout()
		$DIEBITCH8.start()
	if sbuPos >= 7 and crouchOn == 1:
		sbuPos = 0
		$DIEBITCH4.stop()
	if charge <= 0:
		doorOn = 0
		$DoorItself.visible = false
	if charge < 5:
		$CamParent/GenAlert.show()
	elif charge >= 5:
		$CamParent/GenAlert.hide()
	$CamParent/CamItself/MapBg/Generator/Charge.text = str(charge)
	$camFollowmer.look_at(Vector2(get_global_mouse_position().x-OS.window_size.x/2,0)) # facing camera parent leader
	cameraVelocity = Vector2(camSpeed,0).rotated($camFollowmer.rotation) # moving camera parent leader
	if not Input.is_action_pressed("ui_select") and not turnOn == 1 and not maskOn == 1 and not camOn == 1 and not crouchOn == 1: # if allowed to move
		$camFollowmer.position += cameraVelocity # camera parent leader moves
		$camFollowmer.position = Vector2(clamp($camFollowmer.position.x,0,OS.window_size.x),0) # makes sure it's inbound
		$CamParent.position = Vector2(clamp($camFollowmer.position.x,0,OS.window_size.x)+125,0) # and moves camera making sure it's inbound
	if curCam != 0:
		$CamParent/CamItself/CamVP.animation = "cam_0"+str(curCam)
		$CamParent/CamItself/CamVP/Label.text = camNames[curCam]
	$CamParent/WindowBG/Titanawanna.visible = (titanPos >= 5 and turnOn == 1)
	$CamParent/WindowBG/SBU.visible = (sbuPos >= 9 and turnOn == 1)
	$CamParent/WindowBG/BossInWindow.visible = (olgaPos == 7 and turnOn == 1)
	match curCam:
		1:
			$CamParent/CamItself/MapBg/Generator.hide()
			$CamParent/CamItself/CamVP/Max.visible = (maxPos == 4)
			$CamParent/CamItself/CamVP/Milka.visible = (milkPos == 5)
			$CamParent/CamItself/CamVP/Masya.visible = (gopPos == 5 and gopAI > 0)
			$CamParent/CamItself/CamVP/Lentoln.visible = (lentolnPos == 3 and lentolnAI > 0)
			$CamParent/CamItself/CamVP/Boss.visible = (olgaPos == 5 and olgaAI > 0)
		2:
			$CamParent/CamItself/MapBg/Generator.hide()
			$CamParent/CamItself/CamVP/Masya.visible = (gopPos == 4 and gopAI > 0)
			$CamParent/CamItself/CamVP/Max.visible = (maxPos == 3)
			$CamParent/CamItself/CamVP/Lentoln.visible = (lentolnPos == 2 and lentolnAI > 0)
			$CamParent/CamItself/CamVP/Milka.visible = (milkPos == 4)
			$CamParent/CamItself/CamVP/Boss.visible = (olgaPos == 4 and olgaAI > 0)
		3:
			$CamParent/CamItself/CamVP/Lentoln.visible = (lentolnPos == 1 and lentolnAI > 0)
			$CamParent/CamItself/MapBg/Generator.hide()
			$CamParent/CamItself/CamVP/Masya.visible = (gopPos == 3 and gopAI > 0)
			$CamParent/CamItself/CamVP/Max.visible = (maxPos == 1)
			$CamParent/CamItself/CamVP/Milka.visible = (milkPos == 4)
			$CamParent/CamItself/CamVP/Boss.visible = (olgaPos == 3 and olgaAI > 0)
		4:
			$CamParent/CamItself/CamVP/Lentoln.visible = (lentolnPos == 0 and lentolnAI > 0)
			$CamParent/CamItself/MapBg/Generator.show()
			$CamParent/CamItself/CamVP/Milka.hide()
			$CamParent/CamItself/CamVP/Masya.visible = (gopPos == 2 and gopAI > 0)
			$CamParent/CamItself/CamVP/Max.visible = (maxPos == 2)
			$CamParent/CamItself/CamVP/Boss.visible = (olgaPos == 2 and olgaAI > 0)
		5:
			$CamParent/CamItself/CamVP/Lentoln.hide()
			$CamParent/CamItself/CamVP/Masya.visible = (gopPos == 1 and gopAI > 0)
			$CamParent/CamItself/MapBg/Generator.hide()
			$CamParent/CamItself/CamVP/Max.visible = (maxPos == 0)
			$CamParent/CamItself/CamVP/Milka.visible = (milkPos == 1)
			$CamParent/CamItself/CamVP/Boss.visible = (olgaPos == 1 and olgaAI > 0)
		6:
			$CamParent/CamItself/CamVP/Lentoln.hide()
			$CamParent/CamItself/MapBg/Generator.hide()
			$CamParent/CamItself/CamVP/Max.hide()
			$CamParent/CamItself/CamVP/Masya.visible = (gopPos == 0 and gopAI > 0)
			$CamParent/CamItself/CamVP/Milka.visible = (milkPos == 0)
			$CamParent/CamItself/CamVP/Boss.visible = (olgaPos == 0 and olgaAI > 0)

func _input(event):
	if Input.is_action_pressed("ui_left"):
		time += 1
		get_tree().change_scene("res://frames/Win.tscn")
	if turnOn == 0 and camOn == 0 and crouchOn == 0 and event.is_action_pressed("ui_mask") and $CamParent/MaskButton.get_rect().has_point(to_local(event.position-$CamParent/MaskButton.position)): # if pressed lmb while hovering mask button
		match maskOn: # switch block to set value and show/hide mask
			0: # if mask is not on
				maskOn = 1 # put it on
				$CamParent/MaskItself.show() # show it
				$CamParent/CamerasButton.hide() # hide cameras button
				$CrouchButton.hide()
				$TurnButton.hide()
			1:
				maskOn = 0 # pretty much the same things above but inverted
				$CamParent/MaskItself.hide()
				$CamParent/CamerasButton.show()
				$CrouchButton.show()
				$TurnButton.show()
	if turnOn == 0 and not maxPos == 5 and maskOn == 0 and crouchOn == 0 and event.is_action_pressed("ui_mask") and $CamParent/CamerasButton.get_rect().has_point(to_local(event.position-$CamParent/CamerasButton.position)): # if pressed cam button and a shitton of conditions are met
		match camOn: # everything below is the same for the mask but with tablet instead of mask 
			0: # commenting takes 99% of my time
				camOn = 1 # that's why my progress is so slow
				$CamParent/CamItself.show()
				$CamParent/MaskButton.hide()
				$CrouchButton.hide()
				$TurnButton.hide()
			1:
				camOn = 0
				$CamParent/CamItself.hide()
				$CamParent/MaskButton.show()
				$CrouchButton.show()
				$TurnButton.show()
	
#	if Rect2($CamParent/CamItself/MapBg/CamButton1.position,$CamParent/CamItself/MapBg/CamButton1.scale).has_point(to_local(event.position-$CamParent/CamItself/MapBg/CamButton1.position)):
#		print("spotted cursor at cam 01 button")

func _on_startNight_timeout():
	$CamParent/Hint.hide()


func checkSwetlan():
	if swetlanAI > 0:
		if curCam == swetlanPos:
			$CamParent/CamItself/CamVP/Swetlanfedrna.show()
			$DIEBITCH7.start()
		else: 
			$CamParent/CamItself/CamVP/Swetlanfedrna.hide()
			$DIEBITCH7.stop()
			_on_DIEBITCH7_timeout()
	else:
		$CamParent/CamItself/CamVP/Swetlanfedrna.hide()


func _on_Cam1_pressed(): # idfk how to shrink this shit(
	curCam = 1
	checkSwetlan()


func _on_Cam2_pressed(): # 10.07.21 upd: i've realized how to do it but now i am way too lazy to actually do it.
	curCam = 2
	checkSwetlan()


func _on_Cam3_pressed():
	curCam = 3
	checkSwetlan()


func _on_Cam4_pressed():
	curCam = 4
	checkSwetlan()


func _on_Cam5_pressed():
	curCam = 5
	checkSwetlan()


func _on_Cam6_pressed():
	curCam = 6
	checkSwetlan()


func _on_HourClk_timeout():
	time += 1
	$CamParent/Time.text = str(time)+" часов"
	$HourClk.start()
	if night != 7 and (time == 2 or time == 4):
		print("AI increase")
		maxAI += 2
		milkAI += 2
		titanAI += 2
		lentolnAI += 2
		swetlanAI += 2
		gopAI += 2
		sbuAI += 2
		olgaAI += 2
	if time == 6:
		get_tree().change_scene("res://frames/Win.tscn")

func _on_CrouchButton_pressed():
	if maskOn == 0 and turnOn == 0 and camOn == 0: # if pressed crouch button
		match crouchOn: # everything below is the same for the mask but with floor instead of mask
			0: # commenting takes 99% of my time
				crouchOn = 1 # that's why my progress is so slow
				$CamParent/CrouchItself.show()
				$CamParent/CamerasButton.hide()
				$CamParent/MaskButton.hide()
			1:
				crouchOn = 0
				$CamParent/CrouchItself.hide()
				$CamParent/CamerasButton.show()
				$CamParent/MaskButton.show()


func _on_MoveClk_timeout():
	$MoveClk.start()
	$CamParent/Hint.hide()
	var chance = randi() % (20-1) + 1
	print("move clk")
	if chance < maxAI:
		print("moving max")
		maxPos += 1
		print(maxPos)
		if maxPos == 5: # in office
			$BG/MaxInOffice.show() # Showing max in office
			$CamParent/JumpScare.set_animation("Max") # setting jumpscare beforehand
			$Ambient.stop() # stopping bgm1
			$AmbientDanger.stop() # stopping bgm2
			$InOffice.play() # starting bgm3
			if camOn == 1: # shutting cam down
				camOn = 0
				$CamParent/CamItself.hide()
				$CamParent/MaskButton.show()
				$CrouchButton.show()
			$DIEBITCH1.start()
		if maxPos > 2:
			$Ambient.stop()
			$AmbientDanger.play()
	if chance < milkAI:
		print("moving milamori")
		milkPos += 1
		if milkPos == 6: # in office
			$BG/MilkaInOffice.show() # Showing max in office
			$CamParent/JumpScare.set_animation("Milka") # setting jumpscare beforehand
			$DIEBITCH2.start()
	if chance < lentolnAI:
		print("moving lentolna")
		lentolnPos += 1
		if lentolnPos == 4: # in office
			$BG/LentolnInOffice.show() # Showing max in office
			$CamParent/JumpScare.set_animation("Lentoln") # setting jumpscare beforehand
			$Ambient.stop() # stopping bgm1
			$AmbientDanger.stop() # stopping bgm2
			$InOffice.play() # starting bgm3
			if camOn == 1: # shutting cam down
				camOn = 0
				$CamParent/CamItself.hide()
				$CamParent/MaskButton.show()
				$CrouchButton.show()
			$DIEBITCH6.start()
	if chance < titanAI:
		print("moving titanawanna")
		titanPos += 1
		if titanPos == 5:
			print("TITAN attacks")
			$DIEBITCH3.start()
			$CamParent/JumpScare.set_animation("Titan")
	if chance < swetlanAI and SwetlanIntCount % 2 == 0:
		print("moving swetlanfedrna")
		swetlanPos = int(rand_range(1,7))
	if chance < sbuAI:
		print("moving sbu")
		sbuPos += 1
		if sbuPos == 9:
			print("SBU attacks")
			$DIEBITCH4.start()
			$CamParent/JumpScare.set_animation("SBU")
	if chance < gopAI:
		print("moving masya")
		gopPos = clamp(gopPos+1,0,5)
		if gopPos == 5:
			print("Masya attacks")
			$DIEBITCH5.start()
			$CamParent/JumpScare.set_animation("Masya")
	if chance < olgaAI:
		print("moving boss ",olgaPos," ",olgaAI)
		if olgaPos < 5 or olgaPos > 7:
			olgaPos += randi()%2+1
		elif olgaPos == 5:
			print("Olga in office")
			$BG/BossInOffice.show() # Showing max in office
			$CamParent/JumpScare.set_animation("Boss") # setting jumpscare beforehand
			$Ambient.stop() # stopping bgm1
			$AmbientDanger.stop() # stopping bgm2
			$InOffice.play() # starting bgm3
			if camOn == 1: # shutting cam down
				camOn = 0
				$CamParent/CamItself.hide()
				$CamParent/MaskButton.show()
				$CrouchButton.show()
			$DIEBITCH1.start()
		elif olgaPos == 6:
			print("Olga ambush attack")
			$CamParent/JumpScare.set_animation("Boss") # setting jumpscare beforehand
			$DIEBITCH5.start()
		elif olgaPos == 7:
			print("Olga window attack")
			$DIEBITCH3.start()
			$CamParent/JumpScare.set_animation("Boss")
		if olgaPos >= 8:
			#$DIEBITCH8.start() launched in window attack prevention
			print("Olga door attack")
			$BG/BossInOffice2.show()
			$CamParent/JumpScare.set_animation("Boss") # setting jumpscare beforehand
	SwetlanIntCount = 1 + SwetlanIntCount


func _on_DIEBITCH1_timeout():
	print("DIEBITCH1")
	$DIEBITCH1.stop()
	if maskOn == 0:
		print("JUMPSCARE")
		$CamParent/JumpScare.playing = true
		$CamParent/JumpScare.show()
		$JumpscareSound.play()
		$MovGameOver.start()
	elif maskOn == 1:
		print("Spare")
		maxPos = 0
		$BG/MaxInOffice.hide()
		$Ambient.play()
		$InOffice.stop()
		$AmbientDanger.stop()
		$BG/BossInOffice.hide()
		if olgaAI > 0:
			olgaPos = 6
			_on_MoveClk_timeout()


func _on_DIEBITCH2_timeout():
	print("DIEBITCH2")
	$DIEBITCH2.stop()
	if doorOn == 0:
		print("JUMPSCARE")
		$CamParent/JumpScare.playing = true
		$CamParent/JumpScare.show()
		$JumpscareSound.play()
		$MovGameOver.start()
	elif doorOn == 1:
		print("Spare")
		milkPos = 0
		$BG/MilkaInOffice.hide()
		#$BG/BossInOffice2.hide()

func _on_DoorButton_toggled(button_pressed):
#	if button_pressed == true:
#		doorOn = 1
#	elif button_pressed == false:
#		doorOn = 0
	if not charge <= 0:
		doorOn = int(button_pressed)
		$DoorItself.visible = doorOn
	elif charge <= 0:
		$DoorButton.disabled = true
		doorOn = 0
		$DoorItself.visible = 0


func _on_MovGameOver_timeout():
	get_tree().change_scene("res://frames/GameOver.tscn")


func _on_Generator_button_down():
	if charge < 20 and not charge == 0:
		charge += 1


func _on_Discharge_timeout():
	if charge > 0:
		charge -= 1+doorOn*2


func _on_TurnButton_pressed():
	if camOn == 0 and maskOn == 0 and crouchOn == 0:
		match turnOn:
			0:
				turnOn = 1
				$CamParent/WindowBG.show()
				$CamParent/MaskButton.hide()
				$CamParent/CamerasButton.hide()
#				if titanPos >= 5:
#					$CamParent/WindowBG/Titanawanna.show()
#				elif titanPos < 5:
#					$CamParent/WindowBG/Titanawanna.hide()
#				if sbuPos >= 7:
#					$CamParent/WindowBG/SBU.show()
#
#				elif sbuPos < 7:
#					$CamParent/WindowBG/SBU.hide()
#
			1:
				turnOn = 0
				$CamParent/WindowBG.hide()
				$CamParent/MaskButton.show()
				$CamParent/CamerasButton.show()


func _on_DIEBITCH3_timeout():
	print("DIEBITCH3")
	$DIEBITCH3.stop()
	if crouchOn == 0:
		print("JUMPSCARE")
		$CamParent/JumpScare.playing = true
		$CamParent/JumpScare.show()
		if $CamParent/JumpScare.animation == "Titan":
			$CamParent/JumpScare.position = Vector2(503,283)
			$CamParent/JumpScare.scale = Vector2(7,7)
		$JumpscareSound.play()
		$MovGameOver.start()
	elif crouchOn == 1:
		print("Spare")
		titanPos = 0
		$CamParent/WindowBG/Titanawanna.hide()


func _on_DIEBITCH4_timeout():
		print("DIEBITCH4")
		$DIEBITCH4.stop()
		if crouchOn == 0:
			print("JUMPSCARE")
			$MovGameOver.wait_time = 4
			$CamParent/JumpScare.playing = true
			$CamParent/JumpScare.show()
			if $CamParent/JumpScare.animation == "SBU":
				$CamParent/JumpScare.position = Vector2(518.841,809.611)
				$CamParent/JumpScare.scale = Vector2(4,4)
			$JumpscareSound2.play()
			$MovGameOver.start()
			if gopPos >= 6 and night >= 5:
				get_tree().change_scene("res://frames/ending3.tscn")
		elif crouchOn == 1:
			print("Spare")
			sbuPos = 0
			$CamParent/WindowBG/SBU.hide()


func _on_DIEBITCH5_timeout():
	print("DIEBITCH5")
	if gopPos >= 6 or olgaPos == 6:
		print("JUMPSCARE")
		$MovGameOver.wait_time = 4
		$CamParent/JumpScare.playing = true
		$CamParent/JumpScare.show()
		$CamParent/JumpScare.position = Vector2(525,694)
		$CamParent/JumpScare.scale = Vector2(3.493,3.493)
		$JumpscareSound2.play()
		$MovGameOver.start()
		if sbuPos >= 9 and night >= 5:
				get_tree().change_scene("res://frames/ending3.tscn")
	else:
		print("Spare")


func _on_PhoneCall1_finished():
	$PhoneCall1.playing = false


func _on_Audio_pressed():
	$ResetAudio.start()
	if int(round(rand_range(1,100))) == 50:
		$GopDistractor.set_stream(load("res://sounds/playaudio_easter.ogg"))
	else:
		$GopDistractor.set_stream(load("res://sounds/playaudio_"+str(int(round(rand_range(1,5))))+".ogg"))
	#$GopDistractor.play()
	$GopDistractor.playing = true
	print("Playing audio on "+str(curCam))
	AudioWhere = curCam


func _on_ResetAudio_timeout():
	if abs(6-gopPos-AudioWhere) < 2:
		gopPos = 6-AudioWhere
		print("Masya moved to the camera where audio was played."+str(gopPos))
		$DIEBITCH5.stop()
		_on_DIEBITCH5_timeout()
	if olgaAI > 0 and olgaPos == 6:
		olgaPos = 7
		_on_MoveClk_timeout()
	print("Disabling audio")


func _on_DIEBITCH6_timeout():
	print("DIEBITCH6")
	$DIEBITCH6.stop()
	if maskOn == 0:
		print("JUMPSCARE")
		$CamParent/JumpScare.playing = true
		$CamParent/JumpScare.show()
		$CamParent/JumpScare.position = Vector2(514,298)
		$CamParent/JumpScare.scale = Vector2(9.5,9.5)
		$JumpscareSound.play()
		$MovGameOver.start()
	elif maskOn == 1:
		print("Spare")
		lentolnPos = 0
		$BG/LentolnInOffice.hide()
		$Ambient.play()
		$InOffice.stop()
		$AmbientDanger.stop()


func _on_DIEBITCH7_timeout():
	print("DIEBITCH6")
	$DIEBITCH7.stop()
	if curCam == swetlanPos:
		print("JUMPSCARE")
		$CamParent/JumpScare.animation = "Swetlan"
		$CamParent/JumpScare.playing = true
		$CamParent/JumpScare.show()
		$CamParent/JumpScare.position = Vector2(514,298)
		$CamParent/JumpScare.scale = Vector2(9.5,9.5)
		$JumpscareSound.play()
		$MovGameOver.start()


func _on_DIEBITCH8_timeout():
	print("DIEBITCH8")
	$DIEBITCH8.stop()
	if doorOn == 0:
		print("JUMPSCARE")
		$CamParent/JumpScare.playing = true
		$CamParent/JumpScare.show()
		$JumpscareSound.play()
		$MovGameOver.start()
	elif doorOn == 1:
		print("Olga moving out")
		olgaPos = randi()%5
		$BG/BossInOffice2.hide()
		print("Boss respawned at ",olgaPos)
