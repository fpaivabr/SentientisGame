extends Area2D

@onready var dialog_box = $DialogBox
@onready var sound_player = $PCAudioPlayer  # Referência ao AudioStreamPlayer do PC

var player_in_area = false
var pc_completed = false  # Controle para saber se o PC já foi usado

func _ready():
	if dialog_box:
		dialog_box.visible = false
	else:
		print("Erro: DialogBox não encontrado no nó PC.")

	if not sound_player:
		print("Erro: PCAudioPlayer não encontrado no nó PC.")

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
		if pc_completed:
			dialog_box.show_dialog(
				"Agora não!!\nVocê tem muita coisa pra fazer.",
				[]
			)
		else:
			show_dialog()

func show_dialog():
	dialog_box.show_dialog(
		"Conectando ao sistema...",
		["Revisar código", "Bloodborne 3 Remake", "λ Vídeos"]
	)

	# Conecta o evento de escolha das opções
	for button in dialog_box.options_container.get_children():
		button.connect("pressed", Callable(self, "_on_option_selected").bind(button.text))

func _on_option_selected(option: String):
	if option == "Revisar código":
		dialog_box.show_dialog(
			"Está quase pronto. Será que eu já posso...",
			[]
		)
		pc_completed = true
		play_alert_sound()
		update_robot_dialog()
	elif option in ["Bloodborne 3 Remake", "λ Vídeos"]:
		dialog_box.show_dialog(
			"Agora não!!\nVocê tem muita coisa pra fazer.",
			[]
		)

func play_alert_sound():
	if sound_player:
		sound_player.stream = load("res://assets/audio/alert.mp3")
		sound_player.play()
	else:
		print("Erro: PCAudioPlayer não configurado.")

func update_robot_dialog():
	var robot = get_node("../Robot")  # Ajuste o caminho para o robô
	if robot:
		robot.call("activate_phase_two")
