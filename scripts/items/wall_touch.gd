extends Area2D

@onready var dialog_box = $DialogBox  # Faz referência ao DialogBox local
@onready var player = null  # Referência ao player

# Linhas do diálogo
var dialog_lines = [
	"Após anos de pesquisa e dedicação, eu, Simon, estou prestes a realizar algo extraordinário: criar a primeira inteligência artificial consciente.",
	"Mas... que tipo de consciência eu devo projetar? Uma IA que seja puramente lógica pode ser precisa, mas será fria e distante.",
	"Uma IA com empatia humana pode compreender sentimentos, mas corre o risco de cometer erros tolos como os humanos.",
	"Ou talvez um equilíbrio entre razão e emoção seria ideal?",
	"Todas essas escolhas recaem sobre mim... e o futuro está em minhas mãos."
]

var current_line_index = 0  # Índice da linha atual
var dialog_finished = false  # Indica se o diálogo foi concluído
@export var initial_player_position: Vector2 = Vector2(1130, 535)  # Posição inicial para exibir o diálogo

func _ready():
	# Busca o player na cena
	player = get_node_or_null("../../../Player")  # Ajuste o caminho conforme necessário
	if dialog_box:
		dialog_box.visible = false  # DialogBox começa invisível
	else:
		print("Erro: DialogBox não encontrado no WallTouch")  # Debug para problemas

	# Verifica se o player está na posição inicial e se o diálogo ainda não foi concluído
	if player and player.global_position == initial_player_position and not dialog_finished:
		show_next_dialog()

func _on_body_entered(body):
	if body.name == "Player" and not dialog_finished:  # Apenas exibe se o diálogo não foi concluído
		show_next_dialog()

func _on_body_exited(body):
	if body.name == "Player":
		# Fecha o DialogBox ao sair, mas apenas se o diálogo estiver na última linha
		if current_line_index >= dialog_lines.size():
			dialog_box.visible = false

func _process(delta):
	# Avança o diálogo ao pressionar a tecla E (ui_select)
	if dialog_box.visible and Input.is_action_just_pressed("ui_select") and not dialog_finished:
		show_next_dialog()

func show_next_dialog():
	if dialog_box and not dialog_finished:  # Verifica se o diálogo ainda não foi concluído
		if current_line_index < dialog_lines.size():  # Verifica se há mais linhas
			dialog_box.visible = true

			# Adiciona um indicador de "próxima linha" nas linhas intermediárias
			if current_line_index < dialog_lines.size() - 1:  # Da primeira à penúltima linha
				dialog_box.get_node("Label").text = dialog_lines[current_line_index] + "   ▼"
			else:  # Última linha não precisa de indicador
				dialog_box.get_node("Label").text = dialog_lines[current_line_index]

			current_line_index += 1  # Avança para a próxima linha
		else:
			# Diálogo concluído
			dialog_box.visible = false
			dialog_finished = true  # Marca o diálogo como concluído
	else:
		print("Erro: DialogBox não inicializado no WallTouch")  # Debug
