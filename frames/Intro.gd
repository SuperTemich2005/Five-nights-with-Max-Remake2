extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var strings = [
	"Тёмыч: Каникулы!",
	"Наконец-то!",
	"Хотя, у нас еще летом сделают отработку...",
	"Но ничего страшного, главное, что в шкилу-то ходить не заставят!",
	"Море - моя следующая остановка!",
	"(после которой будет будка спасателей, наверняка, но всё же.)",
	"Лягу спать, хоть щас и 12 часов дня.",
	"Эта линейка была весьма, весьма уморительной",
	"Что может пойти не так...?",
	"*звонок*",
	"\"Людмила Буцак\"? А, точно, я так однажды, по нужде, переименовал Егорыча, моего друга.",
	"Опять позовет гулять.",
	"Но ничего, моя сила воли и нежелание гулять сделают своё дело",
	"И я придумаю себе отмазку",
	"И мифическая птица обломинго накроет его планы своим синим крылом.",
	"*ответ*",
	"Егорыч: Дарова Тьоха",
	"Тёмыч: Виделись уже.",
	"Егорыч: Будешь в сватов?",
	"Тёмыч: (А, SWAT4. Забавная, максимально дисбалансная игрушка)",
	"Егогорыч, а как насчет кспы?",
	"Мы там на Титанус собрались лететь.",
	"(KSP, тоже забавная игрушка, особенно, когда туда вкачаны моды)",
	"Егорыч: Можно и в кспу.",
	"Тёмыч: Я подыму серв.",
	"Егорыч: Угу, ответь в скупе.",
	"*сброс*",
	"*Несколько часов спустя, 25 мая 23:00, 2018 год*",
	"*шорох*",
	"Тёмыч: Что это...?",
	"???: Гррр...!",
	"??? 2: Мяу-мяу-мяу!!!",
	"Тёмыч: Так, коты, я вас щас пущу на фарш.",
	"Будут из вас отменная отбивная!",
	"Эээ, отбивные, да...",
	"Опять деретесь?",
	"Макс: Гррр.....",
	"Милка: Мяу-Мяу!",
	"Тёмыч: Так, Миламорда, ты первой будешь",
	"Маська, а давай я тебя щас пшыкалкой запшыкаю?",
	"Милка: Грр...",
	"Макс: Грр...",
	"Тёмыч: ...Че вы пялитесь?",
	"...",
	"...",
	"Тёмыч: ...Я - в дамки",
	"...Что это было???",
	"Тут холодно, что сдохнуть можно",
	"Плюс если они реально хотят меня достать",
	"То они это сделают",
	"Эту ночь я тут переночую, а завтра разбираться будем вместе с Егорычем",
	"*звонок*",
	"Егорыч: Тьоха, щас почти час ночи, что тебе от меня надо?",
	"Тёмыч: Завтра. У АТБ.",
	"Егорыч: Эх, ладно...",
	"26 мая, 12:00",
	"Тёмыч: Дырастуй, Ирод Окаянный",
	"Егорыч: Угу. Так что ты хотел-то, что даже на улицу вышел?",
	"Тёмыч: Макс с Милкой чуть не достали меня",
	"Они почти меня разорвали на маленькие кусочки",
	"Егорыч: Ясно. Тогда, пошли к тебе, + зайдем в магазин техники",
	"Куплю ипишные камеры.",
	"Тёмыч: Угу...",
	"Егорыч: Неодимовые магниты...",
	"Тёмыч: ...",
	"Егорыч: Ну и маску Милки сделаю.",
	"Тёмыч: Поведется Маська разве?",
	"Егорыч: Куда ж она денется...",
	"Тёмыч: Чего бы ты не придумал, другого варианта у меня нет.",\
	"",
]
var cur = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	$DialogueBox.text = strings[0]
	$BGM.play()


func _process(delta):
	pass


func _on_NextButton_pressed():
	cur = cur + 1
	print(cur)
	$DialogueBox.text = strings[cur]
	match cur:
		35-8:
			$ColorRect/Sprite.hide()
			$BGM.stop()
		63-8:
			$ColorRect/Egorich.show()
			$ColorRect/Sprite.show()
			$ColorRect/Sprite.animation = "intro_bg4"
			$ColorRect/Sprite.scale = Vector2(0.695,0.695)
			$ColorRect/Sprite.position = Vector2(508,250)
		77-8:
			get_tree().change_scene("res://frames/nightCOunt.tscn")
