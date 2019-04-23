extends Node2D


const BALL_SPEED = 500
const BALL_BOUNCE_COEFFICIENT = 1.0

#var ball_reflect = true
#var other_player_id = -1

var ball
var ball_vel = Vector2(0,0)
#var ball_movedir

func _ready():
	#First create ourself
	#var thisPlayer = preload("res://Scenes/Player.tscn").instance()
	var thisPlayer = $Players/Player
	thisPlayer.set_name(str(get_tree().get_network_unique_id()))
	thisPlayer.set_network_master(get_tree().get_network_unique_id())
	add_child(thisPlayer)
  
	#Now create the other player
	#var otherPlayer = preload("res://Scenes/Player.tscn").instance()
	var otherPlayer = $Players/Player3
	otherPlayer.set_name(str(Globals.other_player_id))
	otherPlayer.set_network_master(Globals.other_player_id)
	add_child(otherPlayer)
	#player03 = get_node("Player3")
	#player04 = get_node("Player4")
	
	ball = get_node("Ball")
	
	#ball_movedir = Vector2(randf(), randf()).normalized()
	ball_vel = (Vector2(randf(), randf()).normalized()* BALL_SPEED).rotated(rotation)
	pass
	
func _physics_process(delta):

	ball_movment_loop(delta)
	pass
	
func ball_movment_loop(delta):

	var collision = ball.move_and_collide(ball_vel * delta)
	if collision:
		ball_vel = ball_vel.bounce(collision.normal)
		if collision.collider.has_method("hit"):
			collision.collider.hit()
	pass
	
