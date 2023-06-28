extends Node2D

const WORD_COUNT = 500
const SPEED_MIN = 20
const SPEED_MAX = 80


const word_image_1 = preload("res://asset/word_1.png")
const word_image_2 = preload("res://asset/word_2.png")
const word_image_3 = preload("res://asset/word_3.png")


var word_array = [word_image_1, word_image_2, word_image_3]



#var actual_word = getWord()

# ausgeschaltet - funktioniert das? 
# func getWord():
# 	for i in word_array:
# 		var word = rand_range.word_array[i]
# 		print(word) #test ob das so klappt. Was nicht sein wird
# 		return word




var words = []
var shape


class Word:
	var position = Vector2()
	var speed = 1.0
	var body = RID()


func _ready():
	randomize()
	print(word_array[0]) #klappt Array? 

	shape = Physics2DServer.circle_shape_create()
	
	Physics2DServer.shape_set_data(shape, 8)

	for _i in WORD_COUNT:
		var word = Word.new()
		# Give each bulwords own speed.
		word.speed = rand_range(SPEED_MIN, SPEED_MAX)
		word.body = Physics2DServer.body_create()

		Physics2DServer.body_set_space(word.body, get_world_2d().get_space())
		Physics2DServer.body_add_shape(word.body, shape)
		# Don't make bullets check collision with other bullets to improve performance.
		# Their collision mask is still configurwordthe default value, which allows
		# bullets to detect collisions with the player.
		Physics2DServer.body_set_collision_layer(word.body, 0)

		# Place bullets randomly on the viewport and move bullets outside the
		# play area so that they fade in nicely.
		word.position = Vector2(
			rand_range(0, get_viewport_rect().size.x) + get_viewport_rect().size.x,
			rand_range(0, get_viewport_rect().size.y)
		)
		var transform2d = Transform2D()
		transform2d.origin = word.position
		Physics2DServer.body_set_state(word.body, Physics2DServer.BODY_STATE_TRANSFORM, transform2d)

		word.push_back(word)


func _process(_delta):
	# Order the CanvasItem to update every frame.
	update()


func _physics_process(delta):
	var transform2d = Transform2D()
	var offset = get_viewport_rect().size.x + 16
	for word in words:
		word.position.x -= word.speed * delta

		if word.position.x < -16:
			# The bullet has left the screen; move it back to the right.
			word.position.x = offset

		transform2d.origin = word.position

		Physics2DServer.body_set_state(word.body, Physics2DServer.BODY_STATE_TRANSFORM, transform2d)


# Instead of drawing each bullet individually in a script attached to each bullet,
# we are drawing *all* the bullets at once here.
func _draw():
	var offset = -word_image_1.get_size() * 0.5
	for word in words:
		draw_texture(word_image_1, word.position + offset)


# Perform cleanup operations (required to exit without error messages in the console).
func _exit_tree():
	for word in words:
		Physics2DServer.free_rid(word.body)

	Physics2DServer.free_rid(shape)
	words.clear()
