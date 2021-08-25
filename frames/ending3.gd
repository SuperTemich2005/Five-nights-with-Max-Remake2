extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var strings = [
	"",
	"О. Васильевна: Попался...",
	"Тёмыч: Чёрт! *Надевает маску*",
	"О. Васильевна: Я целую ночь торчу здесь, хватит игрушек твоих этих!",
	"Тёмыч: ЛяяяЯЯЯЯ!",
	"О. Васильевна: Вот ты и допрыгалася, мелочь",
	"Пора расплачиваться по долгам",
	"Тёмыч: ИЗЫДИТЕ!",
	"Отче наш, иже се на небе сим! *крестится*",
	"О. Васильевна: ААА! Что ты делаешь???",
	"Тёмыч: Изгоняю дьявола, Ольгасильна.",
	"Отче наш, иже еси на небесах",
	"Да святится имя твоё",
	"Да придет царствие твоё",
	"Да будет волей твоей",
	"Изгнание Ольгасильны, чёртилы позорной, из моей лоджии раз, и навсегда!",
	"О. Васильевна: НЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕТ!",
	"",
]
var cur = 1
var params
# Called when the node enters the scene tree for the first time.
func _ready():
	params = $"/root/GlobalParameters"
	params.ending = 0
	$DialogueBox.text = strings[1]
	$BGM.set_stream(load("res://sounds/AmbienceIntercepting.ogg"))
	$BGM.play()

func _process(delta):
	pass


func _on_NextButton_pressed():
	cur = cur + 1
	$DialogueBox.text = strings[cur]
	if cur == 17:
		params.ending = 1
		get_tree().change_scene("res://frames/ending_summary.tscn")
