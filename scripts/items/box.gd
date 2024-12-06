extends Area2D

@onready var dialog_box = $DialogBox

var player_in_area = false
var box_updated = false  # Controle para verificar se a caixa foi atualizada

func _ready():
	if dialog_box:
		dialog_box.visible = false
	else:
		print("Erro: DialogBox não encontrado no nó Box.")

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
	if box_updated:
		dialog_box.show_dialog(
			"Item encontrado.",
			[]
		)
		update_robot_dialog()
	else:
		dialog_box.show_dialog(
			"Tantas coisas acumuladas,\ndifícil achar qualquer coisa nessa caixa.",
			[]
		)

func update_box_dialog():
	box_updated = true

func update_robot_dialog():
	var robot = get_node("../Robot")  # Ajuste o caminho para o robô
	if robot:
		robot.call("update_dialog_box", "Robô destruído. Gunter resolveu marcar seu território.")
	else:
		print("Erro: Nó Robô não encontrado!")
