extends Timer


# VARIABLE
var count = 0
var count_label
var start_me = false


# SIGNALE
signal all_the_time(my_time) #gibt die erreichte Zeit weiter an record label




# FUNKTIONEN
func _ready():
	count_label = get_node("..") 
	self.connect("timeout", self, "_on_Timer_timeout")
	start()
	

func _on_Timer_timeout():
	if start_me:
		count +=1
		count_label.text = str(count)
		#start(0)



func _on_UI_weitergabe_signal():
	start_me = true



func _on_UI_stopp_countup():
	start_me = false
	emit_signal("all_the_time", count_label.text)
	count = 0


func _on_UI_start_again():
	#count = 0
	#count_label.text = "0"
	start_me = true
	#start()

