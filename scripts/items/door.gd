extends Area2D

# Nome da próxima cena para a qual a porta levará
@export var next_scene: String = ""  # Caminho para a próxima cena
@export var spawn_position: Vector2 = Vector2.ZERO  # Posição inicial do player na próxima cena

# Variável para saber se o player está na área da porta
var player_in_area = false

# Detecta quando o player entra na área da porta
func _on_body_entered(body):
	if body.name == "Player":  # Verifica se o objeto que entrou é o player
		player_in_area = true
		print("Player entrou na área da porta")  # Debug

# Detecta quando o player sai da área da porta
func _on_body_exited(body):
	if body.name == "Player":  # Verifica se o objeto que saiu é o player
		player_in_area = false
		print("Player saiu da área da porta")  # Debug

# Verifica se o player está interagindo com a porta
func _process(delta):
	if player_in_area and Input.is_action_just_pressed("ui_select"):  # Tecla 'E' padrão
		print("Interação detectada, trocando cena...")  # Debug
		change_scene()

# Troca para a próxima cena
func change_scene():
	if next_scene != "":
		print("Mudando para a cena:", next_scene)  # Debug
		# Salva a posição do player para a próxima cena
		GameState.player_position = spawn_position
		# Atualiza a cena atual no GameState
		GameState.current_scene = next_scene
		# Troca para a próxima cena
		get_tree().change_scene_to_file(next_scene)
	else:
		print("Erro: Cena de destino não configurada")  # Debug
