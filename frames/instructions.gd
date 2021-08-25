extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var params
var canSpoil : bool
# Called when the node enters the scene tree for the first time.
func _ready():
	params = $"/root/GlobalParameters"


func _on_Cats_pressed():
	$ColorRect/Cats.show()
	$ColorRect/Teachers.hide()
	$ColorRect/Gov.hide()
	$ColorRect/Bosses.hide()


func _on_Teachers_pressed():
	$ColorRect/Cats.hide()
	$ColorRect/Teachers.show()
	$ColorRect/Gov.hide()
	$ColorRect/Bosses.hide()


func _on_Gov_pressed():
	$ColorRect/Cats.hide()
	$ColorRect/Teachers.hide()
	$ColorRect/Gov.show()
	$ColorRect/Bosses.hide()


func _on_Bosses_pressed():
	if canSpoil == true:
		$ColorRect/Cats.hide()
		$ColorRect/Teachers.hide()
		$ColorRect/Gov.hide()
		$ColorRect/Bosses.show()


func _on_SpoilerMode_pressed():
	canSpoil = bool(abs(1-int(canSpoil)))
	$ColorRect/briefIntro/HBoxContainer/Bosses.visible = canSpoil


func _on_Leave_pressed():
	get_tree().change_scene("res://frames/test.tscn")
