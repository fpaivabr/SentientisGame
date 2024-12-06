extends Area2D

@onready var dialog_box = $DialogBox

var player_in_area = false
var circuit_updated = false  # Controle para verificar se o circuito foi atualizado

func _ready():
	if dialog_box:
		dialog_box.visible = false
	else:
		print("Erro: DialogBox não encontrado no nó ElectricalCircuit.")

func _on_body_entered(body):
	if body.name == "Player":
		player_in_area = true

func _on_body_exited(body):
	if body.name == "Player":
		player_in_area = false
		dialog_box.hide_dialog()

func _process(delta):
	if player_in_area and Input.is_action_just_pressed("ui_select"):
		show_dialog()

func show_dialog():
	if circuit_updated:
		dialog_box.show_dialog(
			"Você tentou ajustar a energia, mas acabou tomando um choque bem forte.",
			[]
		)
	else:
		dialog_box.show_dialog(
			"Esse circuito elétrico anda dando problema...",
			[]
		)

func update_circuit_dialog():
	circuit_updated = true
