extends CharacterBody2D

const SPEED = 300.0  # Velocidade de movimento do player
const JUMP_VELOCITY = -200.0  # Velocidade para o pulo

var interactable_object: Node = null  # Objeto com o qual o player pode interagir

# Função chamada ao carregar a cena
func _ready():
	# Verifica a posição inicial do Player
	if GameState.is_first_scene:
		global_position = Vector2(1130, 535)  # Posição inicial na cena Outside
		GameState.is_first_scene = false
	elif GameState.player_position != Vector2.ZERO:
		global_position = GameState.player_position

	print("Player carregado na posição:", global_position)  # Debug

# Função de física chamada a cada frame
func _physics_process(delta: float):
	# Aplica gravidade e verifica o pulo
	if not is_on_floor():
		velocity.y += get_gravity().y * delta
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Lógica de movimento horizontal
	var direction = Input.get_axis("ui_left", "ui_right")
	velocity.x = direction * SPEED if direction != 0 else move_toward(velocity.x, 0, SPEED)
	move_and_slide()

	# Detecta interação ao pressionar 'E'
	if Input.is_action_just_pressed("ui_select") and interactable_object:
		interactable_object.call("on_player_interact")

# Detecta quando o player entra na área de um objeto interativo
func _on_body_entered(body: Node) -> void:
	if body.has_method("on_player_interact"):
		interactable_object = body
		print("Player pode interagir com:", body.name)

# Detecta quando o player sai da área de um objeto interativo
func _on_body_exited(body: Node) -> void:
	if interactable_object == body:
		interactable_object = null
		print("Player não pode mais interagir com:", body.name)
