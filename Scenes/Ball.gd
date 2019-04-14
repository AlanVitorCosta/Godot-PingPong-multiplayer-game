extends Node2D

const PADDLE_SPEED = 300
const BALL_SPEED = 500
const BALL_BOUNCE_COEFFICIENT = 1.0

#var ball_reflect = true

var player01
var player02
var ball

var players_01_and_02_movedir = Vector2(0,0)
var players_03_and_04_movedir = Vector2(0,0)
var ball_vel = Vector2(0,0)
#var ball_movedir

func _ready():
	print(players_01_and_02_movedir)
	print(ball_vel)
	player01 = get_node("Player1")
	player02 = get_node("Player2")
	#player03 = get_node("Player3")
	#player04 = get_node("Player4")
	ball = get_node("Ball")
	
	#ball_movedir = Vector2(randf(), randf()).normalized()
	ball_vel = (Vector2(randf(), randf()).normalized()* BALL_SPEED).rotated(rotation)
	pass
	
func _physics_process(delta):

	controls_loop()
	paddle_movment_loop()
	ball_movment_loop(delta)
	pass
	
func ball_movment_loop(delta):

	var collision = ball.move_and_collide(ball_vel * delta)
	if collision:
		ball_vel = ball_vel.bounce(collision.normal)
		if collision.collider.has_method("hit"):
			collision.collider.hit()
	pass
	
func controls_loop():
	var left = Input.is_action_pressed("ui_left")
	var right = Input.is_action_pressed("ui_right")
	var up = Input.is_action_pressed("ui_up")
	var down = Input.is_action_pressed("ui_down")
	
	players_01_and_02_movedir.x = -int(left) + int(right)
	players_03_and_04_movedir.y = -int(up) + int(down)
	pass

func paddle_movment_loop():
	player01.move_and_slide((players_01_and_02_movedir.normalized() * PADDLE_SPEED), Vector2(0,0))
	#player02.move_and_slide((players_01_and_02_movedir.normalized() * SPEED), Vector2(0,0))
	#player03.move_and_slide((players_03_and_04_movedir.normalized() * SPEED), Vector2(0,0))
	#player04.move_and_slide((players_03_and_04_movedir.normalized() * SPEED), Vector2(0,0))
	pass