extends Node

# Variável para armazenar a posição do player ao trocar de cena
var player_position: Vector2 = Vector2.ZERO

# Variável para indicar se o cachorro está sendo carregado
var dog_carried: bool = false

# Posição do cachorro ao trocar de cena
var dog_position: Vector2 = Vector2.ZERO

# Variável para armazenar a cena atual do jogo
var current_scene: String = "res://scenes/lab.tscn"
