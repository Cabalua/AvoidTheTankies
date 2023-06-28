extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _draw():
	draw_line(Vector2(1.5, 1.0), Vector2(1.5, 4.0), Color.GREEN, 1.0)
	draw_line(Vector2(4.0, 1.0), Vector2(4.0, 4.0), Color.GREEN, 2.0)
	draw_line(Vector2(7.5, 1.0), Vector2(7.5, 4.0), Color.GREEN, 3.0)
	

func _process(delta):
	queue_redraw()
