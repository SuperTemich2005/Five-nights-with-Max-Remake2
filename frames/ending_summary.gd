extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var params
func _ready():
	params = $"/root/GlobalParameters"
	if params.ending == 0: # нейтральная концовка
		pass # это концовка по дефолту о чем вы лул
	if params.ending == 1: # ольгасильна
		$bg/ending_name.text = "Настоящая концовка"
		$bg/ending_desc.text = "Ольгасильна, в надежде на то, что она *разберётся* с Тьохой, объяснила, что негативный отзыв о школе в картах гугл нанес школе определенной меры ущерб."
		$bg/ending_desc.get_font("font").size = 24
		$bg/ending_pros.text = "+ Вы поняли, почему на вас нападали учителя \n+ Учителя больше на вас не нападают."
		$bg/ending_cons.text = "- Вы не поняли, как телепортируется Светланфедрна \n- Вы не поняли, как летает Титанаванна"
		$bg/ending_whattodo.text = "Гопарь - преступник. СБУ - правозащитники, вроде. Попробуйте их столкнуть?"
	if params.ending == 2: # сбу
		$bg/ending_name.text = "Ментовская концовка"
		$bg/ending_desc.text = "Вы столкнули СБУ с Гопарём. Гопарь исчез бесследно, за то теперь понятно, что он скрывался у вас на дому от СБУ."
		#$bg/ending_desc.get_font("font").size = 24
		$bg/ending_pros.text = "+ Вы поняли, почему на вас нападали спецназовцы и больше они вам не грозят."
		$bg/ending_cons.text = "- Вы не поняли, почему на вас нападают учителя\n- Вы не поняли, почему на вас нападают коты"
		$bg/ending_whattodo.text = "Попробуйте пройти игру, не сталкивая СБУ и Гопаря."


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
