extends Node2D

#var speed = 2000
#var player = self
var touching = 0

onready var sprite = $Sprite

# signale
# signal who_hit_me
# signal png_1
# signal png_2
# signal png_3
# signal png_4
# signal png_5
# signal png_6
# signal png_7
# signal png_8
# signal png_9

signal i_was_hit
signal stop_playing


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	#TEST OB SPRITE DA
	#if sprite: 
		#print("ist da")
		#print(touching)
	
func _input(event):
	if event is InputEventMouseMotion:
		position = event.position - Vector2(0, 16)



func _on_player_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	#emit_signal("who_hit_me")
	touching += 1
	emit_signal("i_was_hit")

	
	if touching == 1:
		sprite.frame = 1
		#emit_signal("png_1")

	if touching == 2:
		sprite.frame = 2
		#emit_signal("png_2")
	
	if touching == 3:
		sprite.frame = 3
		#emit_signal("png_3")

	if touching == 4:
		sprite.frame = 1
		#emit_signal("png_4")

	if touching == 5:
		sprite.frame = 2
		#emit_signal("png_5")

	if touching == 6:
		sprite.frame = 3
		#emit_signal("png_6")

	if touching == 7:
		sprite.frame = 1
		#emit_signal("png_7")

	if touching == 8:
		sprite.frame = 3
		#emit_signal("png_8")

	if touching == 9:
		sprite.frame = 3
		#emit_signal("png_9")


	# end Game: 
	if touching == 10: 
		emit_signal("stop_playing")

	

		#stattdessen soll natürlich z.B. das Spiel beendet werden 




# func _on_words_i_hit_you(name):
# 	print("Der wars ", name)
	
#	print("Der hat mich ", i_hit_you)


func _on_player_stop_playing():
	touching = 0
	sprite.frame = 0

