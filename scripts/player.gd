extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Função chamada quando a cena é carregada
func _ready() -> void:
	# Verifica se há uma posição salva no GameState
	if GameState.player_position != Vector2.ZERO:
		global_position = GameState.player_position  # Posiciona o player na posição salva
		print("Player reposicionado para:", global_position)  # Debug
	else:
		print("Nenhuma posição salva encontrada, usando posição padrão.")  # Debug

# Função chamada a cada frame de física
func _physics_process(delta: float) -> void:
	# Adiciona gravidade ao movimento
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Lida com o pulo
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Movimentação horizontal
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
