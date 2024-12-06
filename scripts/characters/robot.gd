extends Area2D

@onready var dialog_box = $DialogBox
@onready var sound_player = $RobotAudioPlayer  # Referência ao AudioStreamPlayer do robô

var player_in_area = false
var phase_two_active = false  # Controle para ativar a segunda fase do diálogo

func _ready():
	if dialog_box:
		dialog_box.visible = false
	else:
		print("Erro: DialogBox não encontrado no nó Robot.")

	if not sound_player:
		print("Erro: RobotAudioPlayer não encontrado no nó Robot.")

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
			["Tentar ligar ignorando os riscos.", "Ajustar a energia.", "Buscar uma nova fonte."]
		)
	else:
		dialog_box.show_dialog(
			"Que incrível criação!",
			[]
		)

	for button in dialog_box.options_container.get_children():
		button.connect("pressed", Callable(self, "_on_option_selected").bind(button.text))

func _on_option_selected(option: String):
	if phase_two_active:
		match option:
			"Tentar ligar ignorando os riscos.":  # Opção 1
				handle_first_option()
			"Ajustar a energia.":  # Opção 2
				handle_second_option()
			"Buscar uma nova fonte.":  # Opção 3
				handle_third_option()
		play_robot_sound()

# Primeira opção: Exibe um diálogo simples
func handle_first_option():
	dialog_box.show_dialog(
		"O robô acabou sendo ligado no momento errado.\nRecuperou uma bateria e saiu correndo\ndeixando Simon e Gunter assustados.",
		[]
	)

# Segunda opção: Atualiza o circuito
func handle_second_option():
	dialog_box.show_dialog(
		"Você decidiu ajustar a energia.",
		[]
	)
	var circuit = get_node("../ElectricalCircuit")  # Ajuste o caminho para o circuito elétrico
	if circuit:
		circuit.call("update_circuit_dialog")
	else:
		print("Erro: Nó ElectricalCircuit não encontrado!")

# Terceira opção: Atualiza o box
func handle_third_option():
	dialog_box.show_dialog(
		"Onde foi que eu coloquei?",
		[]
	)
	var box = get_node("../Box")  # Ajuste o caminho para a caixa
	if box:
		box.call("update_box_dialog")
	else:
		print("Erro: Nó Box não encontrado!")

func play_robot_sound():
	if sound_player:
		sound_player.stream = load("res://assets/audio/robot.wav")
		sound_player.play()
	else:
		print("Erro: RobotAudioPlayer não configurado.")

func activate_phase_two():
	phase_two_active = true
