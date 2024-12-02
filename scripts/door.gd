extends Area2D

# Nome da próxima cena para a qual a porta levará
@export var next_scene: String = ""
# Posição inicial do player na próxima cena
@export var spawn_position: Vector2 = Vector2.ZERO

# Variável para saber se o Player está na área
var player_in_area = false

# Detecta quando o Player entra na área da porta
func _on_body_entered(body):
	if body.name == "Player":  # Verifica se o objeto é o Player
		player_in_area = true
		print("Player entrou na área da porta")  # Debug

# Detecta quando o Player sai da área da porta
func _on_body_exited(body):
	if body.name == "Player":
		player_in_area = false
		print("Player saiu da área da porta")  # Debug

# Verifica a interação do Player
func _process(delta):
	if player_in_area and Input.is_action_just_pressed("ui_select"):  # Tecla 'E' padrão
		print("Interação detectada, trocando cena...")  # Debug
		change_scene()

# Troca para a próxima cena
func change_scene():
	if next_scene != "":
		print("Mudando para a cena:", next_scene)  # Debug
		
		# Salva a posição inicial do Player no GameState
		GameState.player_position = spawn_position
		
		# Use `change_scene_to_file` diretamente para gerenciar a troca de cena
		get_tree().change_scene_to_file(next_scene)
		
	else:
		print("Erro: A próxima cena não foi configurada.")  # Debug

# Função para instanciar o Player (somente se for necessário após a troca de cena)
func instance_player(scene):
	var player_scene = load("res://scenes/player.tscn").instantiate()
	player_scene.global_position = GameState.player_position
	scene.add_child(player_scene)
	print("Player instanciado na cena:", scene.name)
