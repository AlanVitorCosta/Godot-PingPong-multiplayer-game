extends KinematicBody2D

const PADDLE_SPEED = 300
var players_01_and_02_movedir = Vector2(0,0)
var players_03_and_04_movedir = Vector2(0,0)
var ID;

func _ready():
	#self.position.x = 320
	#self.position.y = 48
	pass 
	
slave func setPosition(pos):
	self.position = pos
	pass
	
master func shutItDown():
	 #Send a shutdown command to all connected clients, including this one
	rpc("shutDown")
	
sync func shutDown():
		get_tree().quit()

func _physics_process(delta):
	controls_loop()
	paddle_movment_loop()
	pass
	
func controls_loop():
	if(is_network_master()):
		var left = Input.is_action_pressed("ui_left")
		var right = Input.is_action_pressed("ui_right")
		var up = Input.is_action_pressed("ui_up")
		var down = Input.is_action_pressed("ui_down")
		players_01_and_02_movedir.x = -int(left) + int(right)
		players_03_and_04_movedir.y = -int(up) + int(down)
		
		if Input.is_key_pressed(KEY_Q):
			shutItDown()
	pass

func paddle_movment_loop():
	self.move_and_slide((players_01_and_02_movedir.normalized() * PADDLE_SPEED), Vector2(0,0))
	
	#player02.move_and_slide((players_01_and_02_movedir.normalized() * SPEED), Vector2(0,0))
	#player03.move_and_slide((players_03_and_04_movedir.normalized() * SPEED), Vector2(0,0))
	#player04.move_and_slide((players_03_and_04_movedir.normalized() * SPEED), Vector2(0,0))
	
	# Tell the other computer about our new position so it can update       
	rpc_unreliable("setPosition",Vector2(self.position.x, self.position.y)) 
	pass