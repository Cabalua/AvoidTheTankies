extends Control


var count = 0
onready var weitergabe = get_node("count_up_label/Timer")
onready var maincell = $cell_container



#Signale an die ZELLEN
signal to_cell_1
signal to_cell_2
signal to_cell_3
signal to_cell_4
signal to_cell_5
signal to_cell_6
signal to_cell_7
signal to_cell_8
signal to_cell_9

#signale an die UI
signal weitergabe_signal
signal stopp_countup
signal start_again

const word_name_1 = "erster"
const word_name_2 = "zweiter"
const word_name_3 = "der Dritte"
const word_name_4 = "der Vierte"
const word_name_5 = "der Fünfte"
const word_name_6 = "der Sechste"
const word_name_7 = "der siebte"
const word_name_8 = "der achte"
const word_name_9 = "der neunte"
#

func _ready(): 
	
	pass

	
	



func _on_player_i_was_hit(): #funktioniert
	count += 1
	if count == 1:
		emit_signal("to_cell_1", word_name_1)
	if count == 2: 
		emit_signal("to_cell_2", word_name_2)
	if count == 3:
		emit_signal("to_cell_3", word_name_3)
	if count == 4:
		emit_signal("to_cell_4", word_name_4)
	if count == 5:
		emit_signal("to_cell_5", word_name_5)
	if count == 6:
		emit_signal("to_cell_6", word_name_6)
	if count == 7:
		emit_signal("to_cell_7", word_name_7)
	if count == 8:
		emit_signal("to_cell_8", word_name_8)
	if count == 9:
		emit_signal("to_cell_9", word_name_9)




func delete_cells():
	for child in maincell.get_children():
		if child is Label:
			var label = child as Label
			label.text = ""

func _on_MAIN_play():
	#print("UI hat Signal erhalten") 
	emit_signal("weitergabe_signal")

func _on_player_stop_playing():
	delete_cells()
	#print("UI hat Stopp-Signal erhalten") #müsste kommen wenn < 9
	emit_signal("stopp_countup")






# REPO
# if weitergabe:
	# 	print("Weitergabe ist da")
	# else:
	# 	print("Weitergabe ist nicht da") 



#	var playerInstace = load("res://player.tscn")
#	var playerPosition = playerInstace.instance.get_node
#
#

#
## Called every frame. 'delta' is the elapsed time since the previous frame.
##func _process(delta):
##	pass


	
	


# func _on_player_who_hit_me():
# 	pass # Replace with function body.


#müsste da noch verbunden werden im anderen? 
# func _on_words_i_hit_you(bullet_name):
# 	print("Ja, ich sehe es ", bullet_name) #funktioniert

# 	#je nach Wort
# #	if 


# func _on_player_png_1():
# 	emit_signal("to_cell_1", word_name_1)


# func _on_player_png_2():
# 	emit_signal("to_cell_2", word_name_2)


# func _on_player_png_3():
# 	emit_signal("to_cell_3", word_name_3)

# func _on_player_png_4():
# 	emit_signal("to_cell_4", word_name_4)


func _on_MAIN_new_game():
	emit_signal("start_again")
