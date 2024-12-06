extends Node

# Controle dos eventos da história
var story_events: Dictionary = {}

# Controle da cena atual
var current_scene: String = "outside"  # Começa na cena "outside"

# Controle de posição do Player
var player_position: Vector2 = Vector2(1130, 535)  # Posição inicial no "outside"

# Controle do Cachorro
var dog_active: bool = false
var dog_position: Vector2 = Vector2.ZERO

# Controle do Robô
var robot_active: bool = false
var robot_position: Vector2 = Vector2.ZERO

# Controle para identificar a primeira cena carregada
var is_first_scene: bool = true
