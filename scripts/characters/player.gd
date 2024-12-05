extends CharacterBody2D

const SPEED = 300.0  # Velocidade de movimento do player
const JUMP_VELOCITY = -400.0  # Velocidade para o pulo

var interactable_object: Node = null  # Objeto que o player pode interagir

# Função chamada quando a cena é carregada
func _ready() -> void:
	if GameState.is_first_scene:
		global_position = Vector2(200, 400)
		GameState.is_first_scene = false
	elif GameState.player_position != Vector2.ZERO:
		global_position = GameState.player_position
	print("Player posicionado em:", global_position)

# Função chamada a cada frame de física
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += get_gravity().y * delta
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	var direction := Input.get_axis("ui_left", "ui_right")
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
