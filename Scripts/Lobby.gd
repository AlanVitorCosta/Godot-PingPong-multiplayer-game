extends Node2D

const PORT = 1234
const MAX_PLAYERS = 4
#var players = []

func _ready():
	
	get_tree().connect("network_peer_connected", self, "_player_connected")
	pass
	
func _player_connected(id):
	print("Player connected to server!")
	Globals.other_player_id = id
	#var game = preload("res://Scenes/Arena.tcsn").instance()
	var game = preload("res://Scenes/Arena.tscn").instance()
	get_tree().get_root().add_child(game)
	hide()
	pass


func _on_ButtonHost_pressed():
	print("Hosting network")
	var host = NetworkedMultiplayerENet.new()
	var res = host.create_server(PORT, MAX_PLAYERS)
	
	if res != OK:
		print("Error creating server")
		return
		
	#$buttonJoin.hide()
	#$buttonHost.disabled = true
	get_tree().set_network_peer(host)
	pass


func _on_ButtonJoin_pressed():
	print("Joining network")
	var host = NetworkedMultiplayerENet.new()
	host.create_client("127.0.0.1", PORT)
	get_tree().set_network_peer(host)
	#$buttonHost.hide()
	#$buttonJoin.disabled = true
	pass
