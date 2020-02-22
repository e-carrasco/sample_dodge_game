extends RigidBody2D

# set the minimum and maximum speed range
export var min_speed = 150
export var max_speed = 250
var mob_types = ["walk", "swim", "fly"]

func _ready():
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]


func _on_Visibility_screen_exited():
	queue_free()

func play():
	$AnimatedSprite.play()

func rotate_anim_h(flip_bool):
	$AnimatedSprite.flip_h = flip_bool
	
func rotate_anim_v(flip_bool):
	$AnimatedSprite.flip_v = flip_bool
