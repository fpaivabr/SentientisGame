extends Node

# Posição do Player ao trocar de cena
var player_position: Vector2 = Vector2.ZERO

# Controle do Cachorro
var dog_active: bool = false
var dog_position: Vector2 = Vector2.ZERO

# Controle do Robô
var robot_active: bool = false
var robot_position: Vector2 = Vector2.ZERO

# Controle da cena atual
var current_scene: String = "res://scenes/environment/lab.tscn"

# Controle para identificar a primeira cena carregada
var is_first_scene: bool = true
