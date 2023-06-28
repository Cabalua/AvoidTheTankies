extends Node2D

var playing = false
var message_text = "Press Space to play"
var message_new_game = "Nochmal? Press Space"

onready var woerter = $words
onready var para = $paral_back


signal play
signal new_game

# Called when the node enters the scene tree for the first time.
func _ready():
	woerter.visible = false #sonst sind die links schon im Bild. 
	displaymessage()
	if woerter:
		print("Wörter da")
	if para:
		print("Para da")
	pass #FRAGE: kann das nicht weg? 



func _input(_event):
	if Input.is_key_pressed(KEY_SPACE):
		emit_signal("play")
		$message.visible = false
		woerter.visible = true

		 


		#print("Taste funktioniert") #J

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func displaymessage():
	$message.text = message_text
	$message.visible = true

	


func _on_player_stop_playing():
	$message.text = message_new_game
	$message.visible = true
	woerter.hide()
	if Input.is_key_pressed(KEY_SPACE):
		emit_signal("new_game")
		emit_signal("play")
		$message.visible = false
		




