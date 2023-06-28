extends Node2D

const BULLET_COUNT = 500
const SPEED_MIN = 20
const SPEED_MAX = 80

const bullet_image_1 = preload("res://asset/word_1.png")
const bullet_image_2 = preload("res://asset/word_2.png")
const bullet_image_3 = preload("res://asset/word_3.png")

var playing = false

#so versuch ich es jetzt
#var bullet_name: Texture


# so hat es funktionerit
#var bullet_name = "Test"

var word_array = [bullet_image_1, bullet_image_2, bullet_image_3]

var bullets = []
var shape

var am_i_hiting = false

# Signals
signal who_is_hit
signal i_hit_you(bullet_name)


# (name: String)  das war der Parameter, den er vorher mit 


class Bullet:
	var position = Vector2()
	var speed = 1.0
	var body = RID()
	var image = null


func _ready():
	randomize()
		
	shape = Physics2DServer.circle_shape_create()
	
	Physics2DServer.shape_set_data(shape, 8)

	for _i in BULLET_COUNT:
		var bullet = Bullet.new()
		bullet.speed = rand_range(SPEED_MIN, SPEED_MAX)
		bullet.body = Physics2DServer.body_create()
		bullet.image = get_random_word(word_array)
			#if am_i_hiting:
			#	emit_signal("i_hit_you", bullet.image.get_path())

		Physics2DServer.body_set_space(bullet.body, get_world_2d().get_space())
		Physics2DServer.body_add_shape(bullet.body, shape)
		Physics2DServer.body_set_collision_layer(bullet.body, 0)

		bullet.position = Vector2(
			rand_range(0, get_viewport_rect().size.x) + get_viewport_rect().size.x,
			rand_range(0, get_viewport_rect().size.y)
		)
		var transform2d = Transform2D()
		transform2d.origin = bullet.position
		Physics2DServer.body_set_state(bullet.body, Physics2DServer.BODY_STATE_TRANSFORM, transform2d)

		bullets.push_back(bullet)
		var bullet_name = bullet
			#return bullet_name



func _process(_delta):
#	testTrueness()
	if playing:
		#print("Playing ist true") #N es ist scheinbar nicht wahr. 
		update()
	#if am_i_hiting: 
#		print("ich treffe gerade")
#	if not am_i_hiting:
#		print("bin draußen")


func _physics_process(delta):
	var transform2d = Transform2D()
	var offset = get_viewport_rect().size.x + 16
	for bullet in bullets:
		bullet.position.x -= bullet.speed * delta

		if bullet.position.x < -16:
			bullet.position.x = offset

		transform2d.origin = bullet.position

		Physics2DServer.body_set_state(bullet.body, Physics2DServer.BODY_STATE_TRANSFORM, transform2d)


func _draw():
	var offset = -word_array[0].get_size() * 0.5
	for bullet in bullets:
		draw_texture(bullet.image, bullet.position + offset)


func _exit_tree():
	for bullet in bullets:
		Physics2DServer.free_rid(bullet.body)

	Physics2DServer.free_rid(shape)
	bullets.clear()

# func testTrueness():
# 	if playing == true:
# 		print("Ja, ich bin die ganze Zeit wahr")
# 	else:
# 		print("NEIN; ICH BIN FALSCH")




func get_random_word(array):
	var randomIndex = randi() % array.size()
	#emit_signal("")
	return array[randomIndex]


func _on_MAIN_play():
	#print("Ich bekomme SIGNAL") #J
	playing = true
	if playing: 
		print("playing ist wahr")
	else: 
		print("playing ist falsch")
		# kann das sein, dass das immer nur dann wahr ist, wenn ich drück 





#kann ich nicht einfach: wenn getroffen, schicke signal? 
#das müsste doch logischerweise an die Tabelle gehen. 
func _on_player_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	am_i_hiting = true
	#print(bullet_name)
#	if bullet_image_1: 
#		bullet_name = bullet_image_1 #hier ist die KRUX
#	if bullet_image_2: 
#		bullet_name = bullet_image_2
	
	#das if ist ja erfüllt, weil das Image true ist. 


	emit_signal("i_hit_you", Texture)


	#so hat es funktioniert
	#emit_signal("i_hit_you", bullet_name)



# func _on_player_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
# 	am_i_hiting=false





func _on_player_stop_playing():
	pass # Replace with function body.


func _on_MAIN_new_game():
	pass # Replace with function body.
