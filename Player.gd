extends Area2D

signal hit

export var speed = 400
var screen_size

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func _ready():
	hide()
	screen_size = get_viewport_rect().size
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var velocity = Vector2()
	velocity = update_velocity(velocity)
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	if velocity.x != 0:
		$AnimatedSprite.animation = "right"
		$AnimatedSprite.flip_v = false
		var x_dir = velocity.x < 0
		$AnimatedSprite.flip_h = x_dir
	elif velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0
	
func update_velocity(velocity):
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	return velocity


func _on_Player_body_entered(body):
	# remove player after being hit
	hide()
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)
