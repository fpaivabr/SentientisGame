extends Area2D

@onready var dialog_box = $DialogBox

var player_in_area = false

func _ready():
	if dialog_box:
		dialog_box.visible = false
	else:
		print("Erro: DialogBox não encontrado no nó Dog.")

func _on_body_entered(body):
	if body.name == "Player":
		player_in_area = true

func _on_body_exited(body):
	if body.name == "Player":
		player_in_area = false
		if dialog_box:
			dialog_box.hide_dialog()

func _process(delta):
	if player_in_area and Input.is_action_just_pressed("ui_select"):
		show_dialog()

func show_dialog():
	if dialog_box:
		dialog_box.show_dialog(
			"Fazendo bagunça no laboratório de novo, Inteligência?",
			["Fazer Carinho", "Chamar Atenção"],
			"dog_intro"
		)
	else:
		print("Erro: DialogBox não inicializado no Dog.")
