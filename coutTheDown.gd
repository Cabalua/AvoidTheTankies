extends Label


onready var countup_timer = $Timer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if countup_timer: 
		print("Timer ist hier")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
