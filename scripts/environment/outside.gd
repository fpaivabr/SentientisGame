extends Node2D

@onready var dialog_box = $DialogBox  # Faz referência ao DialogBox local
@onready var wall_touch = $WallTouch  # Faz referência ao WallTouch
@export var player_scene: PackedScene = preload("res://scenes/characters/player.tscn")  # Cena do Player
@export var player_initial_position: Vector2 = Vector2(1130, 535)  # Posição inicial do Player na Outside

var player_in_area = false  # Controle de interação com o WallTouch

# Função chamada ao carregar a cena
func _ready():
	# Instancia o Player apenas na posição inicial, vindo do Main Menu
	if GameState.is_first_scene:
		instance_player(player_initial_position)
		GameState.is_first_scene = false
	else:
		instance_player(GameState.player_position)

	# Configura o DialogBox
	if dialog_box:
		dialog_box.visible = false  # DialogBox começa invisível
	else:
		print("Erro: DialogBox não encontrado na cena Outside.")  # Debug

	# Configura o WallTouch

# Instancia o Player na posição especificada
func instance_player(position: Vector2):
	if player_scene:
		var player = player_scene.instantiate()
		add_child(player)
		player.global_position = position
		print("Player instanciado em:", position)
	else:
		print("Erro: Cena do Player não encontrada.")  # Debug

# Detecta entrada do Player na área do WallTouch
func _on_body_entered(body):
	if body.name == "Player":
		player_in_area = true
		print("Player pode interagir com o WallTouch.")

# Detecta saída do Player da área do WallTouch
func _on_body_exited(body):
	if body.name == "Player":
		player_in_area = false
		if dialog_box:
			dialog_box.visible = false
		print("Player saiu da área do WallTouch.")

# Lida com interação ao pressionar 'E' (ui_select)
func _process(delta):
	if player_in_area and Input.is_action_just_pressed("ui_select"):
		show_dialog()

# Mostra o diálogo inicial
func show_dialog():
	if dialog_box:
		dialog_box.visible = true
		dialog_box.show_dialog(
			"Após anos de pesquisa e dedicação, eu, Simon, estou prestes a realizar algo extraordinário: criar a primeira inteligência artificial consciente.",
			[]
		)
	else:
		print("Erro: DialogBox não inicializado.")  # Debug
