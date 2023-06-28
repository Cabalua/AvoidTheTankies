extends Timer

var count = 0
var count_label
var start_me = false
signal all_the_time(my_time) #gibt die erreichte Zeit weiter an record button


func _ready():
	count_label = get_node("..") # Ersetzen Sie "Path/To/Your/Label" durch den tatsächlichen Pfad zu Ihrem Label-Knoten
	self.connect("timeout", self, "_on_Timer_timeout")
	start()
	if count_label: 
		print("Count Label ist da ")
	else:
		print("Count Label ist nicht da")


func _on_Timer_timeout():
	if start_me:
		count +=1
		count_label.text = str(count)

		start(0)




	# hier muss noch die erreichte Zeit ermittelt werden und diese dann weitergegeben werden an das Dings 

	#print("Timmer ist aus")
	# count += 1
	# label.text = str(count)




func _on_UI_weitergabe_signal():
	start_me = true



func _on_UI_stopp_countup():
	start_me = false
	emit_signal("all_the_time", count_label.text)


func _on_UI_start_again():
	count = 0
	count_label.text = "0"
	start_me = true
	start()

