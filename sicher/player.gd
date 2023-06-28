extends Area2D

var speed = 2000
var player = self
var touching = 0

onready var sprite = $Sprite


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	if sprite: 
		print("ist da")
		print(touching)
	
func _input(event):
	if event is InputEventMouseMotion:
		position = event.position - Vector2(0, 16)

#
#func _on_body_shape_entered(_body_id, _body, _body_shape, _local_shape):
#	touching += 1
#	if touching >= 1:
#		sprite.frame = 1
##
##
#func _on_body_shape_exited(_body_id, _body, _body_shape, _local_shape):
#	touching -= 1
#	if touching == 0:
#		sprite.frame = 0
#(body_rid, body, body_shape_index, local_shape_index)
# (body_rid, body, body_shape_index, local_shape_index)

func _on_player_body_shape_entered(_body_id, _body, _body_shape, _local_shape):
	touching += 1
	if touching >= 1:
		sprite.frame = 1
		print(touching)

# keine Funktion? Müssten auch noch weitere ran, weil ich ja mehr Frames hab

func _on_player_body_shape_exited(_body_id, _body, _body_shape, _local_shape):
	touching -= 1
	if touching == 0:
		sprite.frame = 0
