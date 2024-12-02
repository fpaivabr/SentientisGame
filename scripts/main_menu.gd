extends Node2D

@onready var buttons = [$StartButton, $InstructionsButton]  # Lista de botões
var selected_index = 0  # Índice do botão selecionado

# Função chamada quando o botão "Iniciar" é pressionado
func _on_start_button_pressed():
	# Troca para a cena do laboratório
	get_tree().change_scene_to_file("res://scenes/lab.tscn")

# Função chamada quando o botão "Manual do Jogo" é pressionado
func _on_instructions_button_pressed():
	# Troca para a cena do manual (how_to_play)
	get_tree().change_scene_to_file("res://scenes/how_to_play.tscn")

# Função chamada a cada frame
func _process(_delta):
	handle_navigation()

# Lida com a navegação no menu
func handle_navigation():
	# Navegar para cima
	if Input.is_action_just_pressed("ui_up"):
		selected_index -= 1
		if selected_index < 0:
			selected_index = buttons.size() - 1  # Volta ao último botão
		update_button_selection()

	# Navegar para baixo
	if Input.is_action_just_pressed("ui_down"):
		selected_index += 1
		if selected_index >= buttons.size():
			selected_index = 0  # Volta ao primeiro botão
		update_button_selection()

	# Ativar botão selecionado com Enter ou ui_select
	if Input.is_action_just_pressed("ui_accept"):  # Usa ui_accept para Enter
		buttons[selected_index].emit_signal("pressed")

# Atualiza o estado visual do botão selecionado
func update_button_selection():
	for i in range(buttons.size()):
		if i == selected_index:
			buttons[i].grab_focus()  # Dá foco ao botão selecionado
			buttons[i].add_theme_color_override("font_color", Color(1, 1, 0))  # Muda a cor do texto para destacar
		else:
			buttons[i].add_theme_color_override("font_color", Color(1, 1, 1))  # Restaura a cor padrão
