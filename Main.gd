extends Node2D

export (PackedScene) var Mob
var score

func _ready():
	randomize()


func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_gameover()

func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$StartTimer.start()


func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()


func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)


func _on_MobTimer_timeout():
	# Chose a random location on Path2D for mob instance to start at
	$MobPath/MobSpawnLocation.set_offset(randf() * 32767)
	
	# Create a Mob instance and add it to the current scene
	var mob = Mob.instance()
	add_child(mob)
	
	# Set Mob direction perpendicular to the path direction
	var direction = $MobPath/MobSpawnLocation.rotation + PI / 2
	
	# Set the Mob's position to a random location
	mob.position = $MobPath/MobSpawnLocation.position
	direction += rand_range(-PI/4, PI/4)
	mob.rotation_degrees = direction
	
	# Set the Mob's velocity
	mob.linear_velocity = Vector2(rand_range(mob.min_speed , mob.max_speed), 0)
	mob.linear_velocity = mob.linear_velocity.rotated(direction)
	
	# Rotate the Animation if needed
	var x_dir = mob.linear_velocity.x < 0
	mob.rotate_anim_h(x_dir)
	mob.rotate_anim_v(mob.linear_velocity.y > 0)
	
	
	# start the animation
	mob.play()

func _on_HUD_start_game():
	new_game()
