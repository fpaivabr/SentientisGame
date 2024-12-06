extends Area2D

@onready var dialog_box = $DialogBox
var player_in_area = false
var phase_two_active = false

func _ready():
	if dialog_box:
		dialog_box.visible = false
	else:
		print("Erro: DialogBox não encontrado no nó Robot")

func _on_body_entered(body):
	if body.name == "Player":
		player_in_area = true

func _on_body_exited(body):
	if body.name == "Player":
		player_in_area = false
		if dialog_box:
			dialog_box.visible = false

func _process(delta):
	if player_in_area and Input.is_action_just_pressed("ui_select"):
		show_dialog()

func show_dialog():
	if phase_two_active:
		dialog_box.show_dialog(
			"Alerta!! Problemas na bateria.",
			["Ativar com risco", "Ajustar energia", "Buscar nova fonte"]
		)
	else:
		dialog_box.show_dialog("Que incrível criação!")
