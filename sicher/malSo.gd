extends Control

const WORD_COUNT = 500
const SPEED_MIN = 20
const SPEED_MAX = 80

const wordArray = ["Hallo", "Welt", "Godot", "Spiel", "Entwicklung"]

var words = []

var font: DynamicFont


class Word:
	var position = Vector2()
	var speed = 1.0
	var word = ""


func _ready():
	randomize()

	font = DynamicFont.new() # Erstelle eine neue DynamicFont-Instanz
	font.font_data = load("res://newFont.tres") # Passe den Pfad zur Schriftart-Ressource an
	font.size = 12 # Passe die Schriftgröße an

	for _i in WORD_COUNT:
		var word = Word.new()
		word.speed = rand_range(SPEED_MIN, SPEED_MAX)
		word.position = Vector2(
			rand_range(0, get_viewport_rect().size.x) + get_viewport_rect().size.x,
			rand_range(0, get_viewport_rect().size.y)
		)
		word.word = wordArray[randi() % wordArray.size()] # Zufälliges Wort aus dem Array auswählen

		words.push_back(word)


func _process(_delta):
	update()


func _physics_process(delta):
	for word in words:
		word.position.x -= word.speed * delta

		if word.position.x < -16:
			word.position.x = get_viewport_rect().size.x + 16

		word.position.y = clamp(word.position.y, 0, get_viewport_rect().size.y)


func _draw():
	for word in words:
		draw_string(font, word.position, word.word)


func _exit_tree():
	words.clear()
