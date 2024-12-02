extends Node2D

@onready var buttons = [$ReturnButton]  # Lista de botões (apenas o botão de retorno)
var selected_index = 0  # Índice do botão selecionado

# Função para retornar à tela inicial
func _on_return_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")  # Volta para a tela inicial

# Função chamada a cada frame
func _process(_delta):
	handle_navigation()

# Lida com a navegação no menu
func handle_navigation():
	# Navegar para cima (no caso de múltiplos botões no futuro)
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
		buttons[selected_index].emit_signal("pressed")  # Emite o sinal do botão selecionado

# Atualiza o estado visual do botão selecionado
func update_button_selection():
	for i in range(buttons.size()):
		if i == selected_index:
			buttons[i].grab_focus()  # Dá foco ao botão selecionado
			buttons[i].add_theme_color_override("font_color", Color(1, 1, 0))  # Muda a cor do texto para destacar
		else:
			buttons[i].add_theme_color_override("font_color", Color(1, 1, 1))  # Restaura a cor padrão
