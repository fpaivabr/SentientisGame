extends Node2D

# Função chamada quando a cena é carregada
func _ready():
	print("Room carregado")  # Debug
	instance_player()

	# Verifica se o robô precisa ser instanciado no room
	if GameState.robot_active:
		instance_robot()

# Função para instanciar o player
func instance_player():
	var player_scene = load("res://scenes/characters/player.tscn").instantiate()
	player_scene.global_position = GameState.player_position
	add_child(player_scene)
	print("Player instanciado no room na posição:", GameState.player_position)

# Função para instanciar o robô
func instance_robot():
	var robot_scene = load("res://scenes/characters/robot.tscn").instantiate()
	robot_scene.global_position = GameState.robot_position
	add_child(robot_scene)
	print("Robô instanciado no room na posição:", GameState.robot_position)
