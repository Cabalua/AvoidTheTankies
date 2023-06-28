extends Node2D

const BULLET_COUNT = 500
const SPEED_MIN = 20
const SPEED_MAX = 80

const bullet_image_1 = preload("res://asset/word_1.png")
const bullet_image_2 = preload("res://asset/word_2.png")
const bullet_image_3 = preload("res://asset/word_3.png")

var word_array = [bullet_image_1, bullet_image_2, bullet_image_3]


var bullets = []
var shape


class Bullet:
	var position = Vector2()
	var speed = 1.0
	var body = RID()


func _ready():
	randomize()
	var randomElement = get_random_word(word_array)
	print(randomElement)
	#funktioniert array: JA 
	#funktioniert random: JA
	print("Ich bin hier ",word_array[0]) 
	print("was anderes? ",word_array[1]) 


	shape = Physics2DServer.circle_shape_create()
	
	Physics2DServer.shape_set_data(shape, 8)

	for _i in BULLET_COUNT:
		var bullet = Bullet.new()
		# Give each bullet its own speed.
		bullet.speed = rand_range(SPEED_MIN, SPEED_MAX)
		bullet.body = Physics2DServer.body_create()

		Physics2DServer.body_set_space(bullet.body, get_world_2d().get_space())
		Physics2DServer.body_add_shape(bullet.body, shape)
		# Don't make bullets check collision with other bullets to improve performance.
		# Their collision mask is still configured to the default value, which allows
		# bullets to detect collisions with the player.
		Physics2DServer.body_set_collision_layer(bullet.body, 0)

		# Place bullets randomly on the viewport and move bullets outside the
		# play area so that they fade in nicely.
		bullet.position = Vector2(
			rand_range(0, get_viewport_rect().size.x) + get_viewport_rect().size.x,
			rand_range(0, get_viewport_rect().size.y)
		)
		var transform2d = Transform2D()
		transform2d.origin = bullet.position
		Physics2DServer.body_set_state(bullet.body, Physics2DServer.BODY_STATE_TRANSFORM, transform2d)

		bullets.push_back(bullet)


func _process(_delta):
	# Order the CanvasItem to update every frame.
	update()


func _physics_process(delta):
	var transform2d = Transform2D()
	var offset = get_viewport_rect().size.x + 16
	for bullet in bullets:
		bullet.position.x -= bullet.speed * delta

		if bullet.position.x < -16:
			# The bullet has left the screen; move it back to the right.
			bullet.position.x = offset

		transform2d.origin = bullet.position

		Physics2DServer.body_set_state(bullet.body, Physics2DServer.BODY_STATE_TRANSFORM, transform2d)


# Instead of drawing each bullet individually in a script attached to each bullet,
# we are drawing *all* the bullets at once here.
func _draw():
	var offset = -bullet_image_1.get_size() * 0.5
	for bullet in bullets:
		draw_texture(bullet_image_1, bullet.position + offset)


# Perform cleanup operations (required to exit without error messages in the console).
func _exit_tree():
	for bullet in bullets:
		Physics2DServer.free_rid(bullet.body)

	Physics2DServer.free_rid(shape)
	bullets.clear()

func get_random_word(array):
	var randomIndex = randi() % array.size()
	return array[randomIndex]
	
