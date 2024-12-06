extends Area2D

@onready var dialog_box = $DialogBox
@onready var sound_player = $PCAudioPlayer  # Referência ao AudioStreamPlayer do PC

var player_in_area = false

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
		show_dialog()

func show_dialog():
	if dialog_box:
		dialog_box.show_dialog(
			"Conectando ao sistema...",
			["Revisar código", "Bloodborne 3 Remake", "λ Vídeos"]
		)
		play_sound()
	else:
		print("Erro: DialogBox não inicializado no PC.")

func play_sound():
	if sound_player:
		sound_player.stream = load("res://assets/audio/pc_keyboard.wav")
		sound_player.play()
	else:
		print("Erro: PCAudioPlayer não configurado.")
