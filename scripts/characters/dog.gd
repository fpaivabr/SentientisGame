extends Area2D

@onready var dialog_box = $DialogBox  # Faz referência ao DialogBox local

var player_in_area = false

func _ready():
	if dialog_box:
		dialog_box.visible = false  # DialogBox começa invisível
	else:
		print("Erro: DialogBox não encontrado no nó Dog")  # Debug para problemas

func _on_body_entered(body):
	if body.name == "Player":
		player_in_area = true

func _on_body_exited(body):
	if body.name == "Player":
		player_in_area = false
		if dialog_box:
			dialog_box.visible = false  # Esconde o DialogBox quando o player sai

func _process(delta):
	if player_in_area and Input.is_action_just_pressed("ui_select"):
		show_dialog()

func show_dialog():
	if dialog_box:
		dialog_box.visible = true
		dialog_box.get_node("Label").text = "O cachorro parece agitado, mas amigável."
	else:
		print("Erro: DialogBox não inicializado no Dog")  # Debug
