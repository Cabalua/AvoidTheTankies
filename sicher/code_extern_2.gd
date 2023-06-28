func _emit_word():
	var word = words[randi() % words.size()]
	var speed = rand_range(50.0, 200.0)  # Zufällige Geschwindigkeit zwischen 50 und 200
	var distance = rand_range(100.0, 400.0)  # Zufälliger Abstand zwischen 100 und 400
	var word_instance = Control.new()
	var label = Label.new()
	label.text = word
	word_instance.add_child(label)
	word_instance.rect_min_size = label.rect_min_size  # Größe des Controls auf die Größe des Labels setzen
	word_instance.rect_pivot = Vector2(0.5, 0.5)  # Pivotpunkt des Controls in der Mitte setzen
	word_instance.position = Vector2(rand_range(0, get_viewport().size.x), -distance)
	add_child(word_instance)
	word_instance.add_collision_exception_with(self)  # Kollision mit dem Area2D vermeiden
	word_instance.add_child(CollisionShape2D.new())  # Kollisionsshape hinzufügen
	var body = KinematicBody2D.new()
	body.add_child(word_instance)
	body.linear_velocity = Vector2(0, speed)
	add_child(body)
