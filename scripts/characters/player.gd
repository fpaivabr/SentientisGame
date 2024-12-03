extends CharacterBody2D

const SPEED = 300.0  # Velocidade de movimento do player
const JUMP_VELOCITY = -400.0  # Velocidade para o pulo

# Função chamada quando a cena é carregada
func _ready() -> void:
	# Verifica se o jogo está na primeira cena
	if GameState.is_first_scene:
		# Define a posição inicial no Lab (primeira cena)
		global_position = Vector2(200, 400)
		GameState.is_first_scene = false  # Atualiza o estado para indicar que já passou pela primeira cena
		print("Player instanciado na posição inicial do Lab:", global_position)  # Debug
	elif GameState.player_position != Vector2.ZERO:
		# Caso não seja a primeira cena, reposiciona o player na última posição salva
		global_position = GameState.player_position
		print("Player reposicionado para:", global_position)  # Debug
	else:
		print("Nenhuma posição salva encontrada, usando posição padrão.")  # Debug

# Função chamada a cada frame de física
func _physics_process(delta: float) -> void:
	# Aplica gravidade ao movimento vertical
	if not is_on_floor():
		velocity.y += get_gravity().y * delta

	# Lida com o pulo
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Movimentação horizontal com base no input do jogador
	var direction := Input.get_axis("ui_left", "ui_right")  # Obtém direção (-1, 0 ou 1)
	if direction != 0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)  # Reduz gradualmente a velocidade para 0

	move_and_slide()  # Executa o movimento do player com colisões
