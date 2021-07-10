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
var AudioOn

# Called when the node enters the scene tree for the first time.
func _ready():
	var params = get_node("/root/GlobalParameters")
	# Time
	time = 0
	night = params.night
	$CamParent/Night.text = str(night)+" ночь"
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
	if gopAI <= 0:
		$CamParent/CamItself/CamVP/Masya.hide()
	else:
		$CamParent/CamItself/CamVP/Masya.show()
	if night != null and night < 7:
		$PhoneCall1.set_stream(load("res://sounds/phonecall"+str(night)+".ogg"))
	else:
		$PhoneCall1.remove_and_skip()
		print("No phone call for night "+str(night))
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#camVel = get_global_mouse_position().x-OS.window_size.x/2
	#$CamParent.position.x = clamp(camVel,0,1024)
	if titanPos >= 5 and crouchOn == 1:
		titanPos = 0
		$DIEBITCH3.stop()
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
	if titanPos >= 5 and turnOn == 1:
		$CamParent/WindowBG/Titanawanna.show()
	elif titanPos < 5 and turnOn == 1:
		$CamParent/WindowBG/Titanawanna.hide()
	if sbuPos >= 9 and turnOn == 1:
		$CamParent/WindowBG/SBU.show()
		
	elif sbuPos < 9 and turnOn == 1:
		$CamParent/WindowBG/SBU.hide()
		
	match curCam:
		1:
			$CamParent/CamItself/MapBg/Generator.hide()
			if maxPos == 4:
				$CamParent/CamItself/CamVP/Max.show()
			else:
				$CamParent/CamItself/CamVP/Max.hide()
				
			if milkPos == 5:
				$CamParent/CamItself/CamVP/Milka.show()
			else:
				$CamParent/CamItself/CamVP/Milka.hide()
			if gopPos == 5:
				$CamParent/CamItself/CamVP/Masya.show()
			else:
				$CamParent/CamItself/CamVP/Masya.hide()
		2:
			$CamParent/CamItself/MapBg/Generator.hide()
			if gopPos == 4:
				$CamParent/CamItself/CamVP/Masya.show()
			else:
				$CamParent/CamItself/CamVP/Masya.hide()
			if maxPos == 3:
				$CamParent/CamItself/CamVP/Max.show()
			else:
				$CamParent/CamItself/CamVP/Max.hide()
				
			if milkPos == 4:
				$CamParent/CamItself/CamVP/Milka.show()
			else:
				$CamParent/CamItself/CamVP/Milka.hide()
		3:
			$CamParent/CamItself/MapBg/Generator.hide()
			if gopPos == 3:
				$CamParent/CamItself/CamVP/Masya.show()
			else:
				$CamParent/CamItself/CamVP/Masya.hide()
			if maxPos == 1:
				$CamParent/CamItself/CamVP/Max.show()
			else:
				$CamParent/CamItself/CamVP/Max.hide()
			
			if milkPos == 3:
				$CamParent/CamItself/CamVP/Milka.show()
			else:
				$CamParent/CamItself/CamVP/Milka.hide()
		4:
			$CamParent/CamItself/MapBg/Generator.show()
			if gopPos == 2:
				$CamParent/CamItself/CamVP/Masya.show()
			else:
				$CamParent/CamItself/CamVP/Masya.hide()
			$CamParent/CamItself/CamVP/Milka.hide()
			if maxPos == 2:
				$CamParent/CamItself/CamVP/Max.show()
			else:
				$CamParent/CamItself/CamVP/Max.hide()
		5:
			if gopPos == 1:
				$CamParent/CamItself/CamVP/Masya.show()
			else:
				$CamParent/CamItself/CamVP/Masya.hide()
			$CamParent/CamItself/MapBg/Generator.hide()
			if maxPos == 0:
				$CamParent/CamItself/CamVP/Max.show()
			else:
				$CamParent/CamItself/CamVP/Max.hide()
				
			if milkPos == 1:
				$CamParent/CamItself/CamVP/Milka.show()
			else:
				$CamParent/CamItself/CamVP/Milka.hide()
		6:
			$CamParent/CamItself/MapBg/Generator.hide()
			$CamParent/CamItself/CamVP/Max.hide()
			if gopPos == 0:
				$CamParent/CamItself/CamVP/Masya.show()
			else:
				$CamParent/CamItself/CamVP/Masya.hide()
			if milkPos == 0:
				$CamParent/CamItself/CamVP/Milka.show()
			else: 
				$CamParent/CamItself/CamVP/Milka.hide()

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


func _on_Cam1_pressed(): # idfk how to shrink this shit(
	curCam = 1
	


func _on_Cam2_pressed(): # 10.07.21 upd: i've realized how to do it but now i am way too lazy to actually do it.
	curCam = 2


func _on_Cam3_pressed():
	curCam = 3


func _on_Cam4_pressed():
	curCam = 4


func _on_Cam5_pressed():
	curCam = 5


func _on_Cam6_pressed():
	curCam = 6


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
	if gopAI <= 0:
		$CamParent/CamItself/CamVP/Masya.hide()
	else:
		$CamParent/CamItself/CamVP/Masya.show()
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
	if chance < titanAI:
		print("moving titanawanna")
		titanPos += 1
		if titanPos == 5:
			print("TITAN attacks")
			$DIEBITCH3.start()
			$CamParent/JumpScare.set_animation("Titan")
	if chance < swetlanAI:
		print("moving swetlanfedrna")
		swetlanPos += 1
	if chance < sbuAI:
		print("moving sbu")
		sbuPos += 1
		if sbuPos == 9:
			print("SBU attacks")
			$DIEBITCH4.start()
			$CamParent/JumpScare.set_animation("SBU")
	if chance < gopAI:
		print("moving masya")
		if AudioOn:
			if abs(6-gopPos-AudioWhere) < 2:
				gopPos = 6-AudioWhere
				print("Masya moved to the camera where audio was played."+str(gopPos))
				$DIEBITCH5.stop()
				_on_DIEBITCH5_timeout()
			else:
				print("Sound played too far away "+str(abs(6-gopPos-AudioWhere))+" "+str(6-gopPos)+" "+str(AudioWhere))
				gopPos = clamp(gopPos+1,0,5)
		else:
			gopPos = clamp(gopPos+1,0,5)
		if gopPos == 5:
			print("Masya attacks")
			$DIEBITCH5.start()
			$CamParent/JumpScare.set_animation("Masya")
	if chance < olgaAI:
		print("moving boss")
		olgaPos += 1


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
				if titanPos >= 5:
					$CamParent/WindowBG/Titanawanna.show()
				elif titanPos < 5:
					$CamParent/WindowBG/Titanawanna.hide()
				if sbuPos >= 7:
					$CamParent/WindowBG/SBU.show()
					
				elif sbuPos < 7:
					$CamParent/WindowBG/SBU.hide()
					
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
			
		elif crouchOn == 1:
			print("Spare")
			sbuPos = 0
			$CamParent/WindowBG/SBU.hide()


func _on_DIEBITCH5_timeout():
	print("DIEBITCH5")
	if gopPos == 6:
		print("JUMPSCARE")
		$MovGameOver.wait_time = 4
		$CamParent/JumpScare.playing = true
		$CamParent/JumpScare.show()
		$CamParent/JumpScare.position = Vector2(525,694)
		$CamParent/JumpScare.scale = Vector2(3.493,3.493)
		$JumpscareSound2.play()
		$MovGameOver.start()
	else:
		print("Spare")


func _on_PhoneCall1_finished():
	$PhoneCall1.playing = false


func _on_Audio_pressed():
	$ResetAudio.start()
	print("Playing audio on"+str(curCam))
	AudioWhere = curCam
	AudioOn = 1


func _on_ResetAudio_timeout():
	AudioOn = 0
	print("Disabling audio")



