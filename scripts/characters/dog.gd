extends Area2D

@onready var dialog_box = $DialogBox
@onready var sound_player = $DogAudioPlayer  # Referência ao AudioStreamPlayer do cachorro

var player_in_area = false

func _ready():
	if dialog_box:
		dialog_box.visible = false
	else:
		print("Erro: DialogBox não encontrado no nó Dog.")

	if not sound_player:
		print("Erro: DogAudioPlayer não encontrado no nó Dog.")

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
			"Fazendo bagunça no laboratório de novo, Gunter?",
			["Fazer Carinho", "Chamar Atenção"],
			"dog_intro"
		)
		play_sound()
	else:
		print("Erro: DialogBox não inicializado no Dog.")

func play_sound():
	if sound_player:
		sound_player.stream = load("res://assets/audio/dog_bark.wav")
		sound_player.play()
	else:
		print("Erro: DogAudioPlayer não configurado.")
