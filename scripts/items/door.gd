extends Area2D

@export var next_scene: String = ""  # Caminho para a próxima cena
@export var spawn_position: Vector2 = Vector2.ZERO  # Posição inicial do player na próxima cena

@onready var sound_player = $AudioStreamPlayer  # Referência ao AudioStreamPlayer
var player_in_area = false  # Indica se o player está na área da porta

func _ready():
	# Ajusta a posição inicial do player dependendo da próxima cena e da porta
	if next_scene == "res://scenes/environment/lab.tscn":
		if name == "InsideDoor":
			spawn_position = Vector2(255, 502)
		elif name == "OutsideDoor":
			spawn_position = Vector2(1014, 478)
	elif next_scene == "res://scenes/environment/room.tscn":
		spawn_position = Vector2(228, 504)
	elif next_scene == "res://scenes/environment/outside.tscn":
		spawn_position = Vector2(66, 486)

	if not sound_player:
		print("Erro: AudioStreamPlayer não encontrado na porta.")

# Detecta quando o player entra na área da porta
func _on_body_entered(body):
	if body.name == "Player":  # Verifica se o objeto que entrou é o player
		player_in_area = true
		print("Player entrou na área da porta.")  # Debug

# Detecta quando o player sai da área da porta
func _on_body_exited(body):
	if body.name == "Player":  # Verifica se o objeto que saiu é o player
		player_in_area = false
		print("Player saiu da área da porta.")  # Debug

# Verifica se o player está interagindo com a porta
func _process(delta):
	if player_in_area and Input.is_action_just_pressed("ui_select"):  # Tecla 'E' padrão
		print("Interação detectada, trocando cena...")  # Debug
		play_door_sound()
		change_scene()

# Reproduz o som da porta
func play_door_sound():
	if sound_player:
		if name == "OutsideDoor":
			sound_player.stream = load("res://assets/audio/outsidedoor.wav")
		elif name == "InsideDoor":
			sound_player.stream = load("res://assets/audio/insidedoor.wav")
		else:
			print("Erro: Nome da porta desconhecido.")
		sound_player.play()
	else:
		print("Erro: AudioStreamPlayer não configurado na porta.")

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
		print("Erro: Cena de destino não configurada.")  # Debug
