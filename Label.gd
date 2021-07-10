extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var strings = [
	"Temich: We are in Godot mates",
	"Egorich: Impossible",
	"Temich: Shaddup mate, everything is possible!",
]
var stringsRus = [
	"Тёмыч: Мы таки в годоте, господа",
	"Егорыч: Невозможно...!",
	"Тёмыч: Ух, еще как возможно, Ирод Окаянный!",
]
var cur
var language

# Called when the node enters the scene tree for the first time.
func _ready():
	cur = 0
	language = "Rus"
	if language == "Eng":
		text = strings[cur]
	if language == "Rus":
		text = stringsRus[cur]



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	cur = cur + 1
	if language == "Eng":
		text = strings[cur]
	if language == "Rus":
		text = stringsRus[cur]
