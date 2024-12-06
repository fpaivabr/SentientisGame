extends Area2D

@onready var dialog_box = $DialogBox  # Faz referência ao DialogBox local

# Linhas do diálogo
var dialog_lines = [
	"Após anos de pesquisa e dedicação, eu, Simon, estou prestes a realizar algo extraordinário: criar a primeira inteligência artificial consciente.",
	"Mas... que tipo de consciência eu devo projetar? Uma IA que seja puramente lógica pode ser precisa, mas será fria e distante.",
	"Uma IA com empatia humana pode compreender sentimentos, mas corre o risco de cometer erros tolos como os humanos.",
	"Ou talvez um equilíbrio entre razão e emoção seria ideal?",
	"Todas essas escolhas recaem sobre mim... e o futuro está em minhas mãos."
]

var current_line_index = 0  # Índice da linha atual
var player_in_area = false

func _ready():
	if dialog_box:
		dialog_box.visible = false  # DialogBox começa invisível
	else:
		print("Erro: DialogBox não encontrado no WallTouch")  # Debug para problemas

func _on_body_entered(body):
	if body.name == "Player":
		player_in_area = true

func _on_body_exited(body):
	if body.name == "Player":
		player_in_area = false
		# Só esconde o DialogBox se o diálogo estiver na última linha
		if current_line_index >= dialog_lines.size():
			dialog_box.visible = false

func _process(delta):
	if player_in_area and Input.is_action_just_pressed("ui_select"):  # Pressiona E
		show_next_dialog()

	# Fecha o DialogBox ao mover, mas apenas se for a última linha
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
		if current_line_index >= dialog_lines.size():
			dialog_box.visible = false

func show_next_dialog():
	if dialog_box:
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
			current_line_index = 0  # Reinicia o índice do diálogo
	else:
		print("Erro: DialogBox não inicializado no WallTouch")  # Debug
