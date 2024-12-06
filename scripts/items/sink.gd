extends Area2D

@onready var dialog_box = $DialogBox  # Faz referência ao DialogBox local

var player_in_area = false

func _ready():
	# Verifica se o DialogBox foi encontrado
	if dialog_box:
		dialog_box.visible = false  # DialogBox começa invisível
		print("DialogBox encontrado na Sink")  # Debug para confirmar
	else:
		print("Erro: DialogBox não encontrado no nó Sink")  # Debug para problemas

func _on_body_entered(body):
	# Detecta quando o player entra na área da pia
	if body.name == "Player":
		player_in_area = true
		print("Player entrou na área da Sink")  # Debug

func _on_body_exited(body):
	# Detecta quando o player sai da área da pia
	if body.name == "Player":
		player_in_area = false
		if dialog_box:
			dialog_box.visible = false  # Esconde o DialogBox quando o player sai
		print("Player saiu da área da Sink")  # Debug

func _process(delta):
	# Verifica interação ao pressionar "E"
	if player_in_area and Input.is_action_just_pressed("ui_select"):
		print("Interagindo com a Sink...")  # Debug
		show_dialog()

func show_dialog():
	# Mostra o DialogBox com a mensagem apropriada
	if dialog_box:
		dialog_box.visible = true
		dialog_box.get_node("Label").text = "A pia está pingando água lentamente."
		print("DialogBox exibido na Sink")  # Debug
	else:
		print("Erro: DialogBox não inicializado no Sink")  # Debug
