extends Node2D

func _on_Back_timeout():
	get_tree().change_scene("res://frames/test.tscn")
