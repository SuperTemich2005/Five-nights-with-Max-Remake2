extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var strings = [
	"",
	"СБУ 1: Стоять не двигаться!",
	"Тёмыч: ААА! Не бейте!",
	"СБУ 2: Мы не тебе, мелкий. Прочь с дороги!",
	"Гопарь: Чёрт! Как вы меня нашли?!",
	"СБУ 3: Вы окружены, сдавайтесь!",
	"Гопарь: Никогда!",
	"*Пшш*",
	"СБУ 1: Что?! Куда он делся?!",
	"Тёмыч: Да кто вы все такие и кто это такой?",
	"СБУ 2: Мася из 'Меридиана', но это не твоё дело.",
	"СБУ 3: Блин, еще одно окно чинить...",
	"СБУ 1: Это ты предложил окно ломать, вообще-то.",
	"СБУ 3: Та пошел ты...",
	"Тёмыч: (Ну и ну...)",
	"(СБУ? На моей лоджии?)",
	"...Как бы то ни было.",
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
	if cur == 15-8:
		$gop.hide()
	if cur == 25-8:
		params.ending = 2
		get_tree().change_scene("res://frames/ending_summary.tscn")
