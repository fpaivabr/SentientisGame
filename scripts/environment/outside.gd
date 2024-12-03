extends Node2D

# Função chamada quando a cena é carregada
func _ready():
	print("Outside carregado")  # Debug
	instance_player()

	# Verifica se o cachorro precisa ser instanciado no outside
	if GameState.dog_active:
		instance_dog()

# Função para instanciar o player
func instance_player():
	var player_scene = load("res://scenes/characters/player.tscn").instantiate()
	player_scene.global_position = GameState.player_position
	add_child(player_scene)
	print("Player instanciado no outside na posição:", GameState.player_position)

# Função para instanciar o cachorro
func instance_dog():
	var dog_scene = load("res://scenes/characters/dog.tscn").instantiate()
	dog_scene.global_position = GameState.dog_position
	add_child(dog_scene)
	print("Cachorro instanciado no outside na posição:", GameState.dog_position)
