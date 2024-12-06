extends Area2D

@onready var dialog_box = $DialogBox  # Referência ao DialogBox
@onready var sound_player = $SinkAudioPlayer  # Referência ao AudioStreamPlayer da pia

var player_in_area = false

func _ready():
	if dialog_box:
		dialog_box.visible = false
	else:
		print("Erro: DialogBox não encontrado no nó Sink.")

	if not sound_player:
		print("Erro: SinkAudioPlayer não encontrado no nó Sink.")

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
			"Tirei o chuveiro daqui pra consertar.\nOnde foi que eu meti?",
			[]
		)
		play_sound()
	else:
		print("Erro: DialogBox não inicializado no Sink.")

func play_sound():
	if sound_player:
		sound_player.stream = load("res://assets/audio/bathroom_sink.wav")
		sound_player.play()
	else:
		print("Erro: SinkAudioPlayer não configurado.")
