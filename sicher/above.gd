extends Area2D

var words := ["Word1", "Word2", "Word3", "Word4", "Word5", "Word6", "Word7", "Word8", "Word9", "Word10"]

func _ready():
	randomize()
	start_emitting_words()

func start_emitting_words():
	var timer = Timer.new()
	timer.wait_time = rand_range(0.5, 2.0) # Zufällige Wartezeit zwischen 0.5 und 2.0 Sekunden
	timer.one_shot = false # Timer wiederholt sich
	timer.connect("timeout", self, "_emit_word")
	add_child(timer)
	timer.start()

func _emit_word():
	var word = words[randi() % words.size()]
	var speed = rand_range(50.0, 200.0)  # Zufällige Geschwindigkeit zwischen 50 und 200
	var distance = rand_range(100.0, 400.0)  # Zufälliger Abstand zwischen 100 und 400
	var word_instance = Control.new()
	var label = Label.new()
	label.text = word
	word_instance.add_child(label)
	word_instance.rect_min_size = label.rect_min_size  # Größe des Controls auf die Größe des Labels setzen
	word_instance.rect_global_position = Vector2(rand_range(0, get_viewport().size.x), -distance)
	add_child(word_instance)
	word_instance.add_to_group("no_collision")  # Füge das Control der Kollisionsgruppe "no_collision" hinzu
	word_instance.add_child(CollisionShape2D.new())  # Kollisionsshape hinzufügen
	var body = KinematicBody2D.new()
	body.add_child(word_instance)
	body.linear_velocity = Vector2(0, speed)  # Setze die lineare Geschwindigkeit des KinematicBody2D
	add_child(body)

func _on_Word_collision(body: KinematicBody2D) -> void:
	var word_instance = body.get_child(0) as Control  # Erhalte das Wort-Instanz-Knoten
	var word = word_instance.get_child(0).text  # Erhalte den Text des Labels im Wort-Instanz-Knoten
	# Handle Kollision mit dem Wort
	# Zum Beispiel: Entferne das Wort, aktualisiere Punkte usw.
	word_instance.queue_free()
