extends Node2D

@onready var buttons = [$StartButton, $InstructionsButton]  # Lista de botões
var selected_index = 0  # Índice do botão selecionado

# Função chamada quando o botão "Iniciar" é pressionado
func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/environment/lab.tscn")  # Troca para a cena do laboratório

# Função chamada quando o botão "Manual do Jogo" é pressionado
func _on_instructions_button_pressed():
	get_tree().change_scene_to_file("res://scenes/ui/how_to_play.tscn")  # Troca para a cena do manual

# Função chamada a cada frame
func _process(_delta):
	handle_navigation()

# Lida com a navegação no menu
func handle_navigation():
	if Input.is_action_just_pressed("ui_up"):
		selected_index -= 1
		if selected_index < 0:
			selected_index = buttons.size() - 1  # Volta ao último botão
		update_button_selection()

	if Input.is_action_just_pressed("ui_down"):
		selected_index += 1
		if selected_index >= buttons.size():
			selected_index = 0  # Volta ao primeiro botão
		update_button_selection()

	# Ativar botão selecionado com Enter ou ui_accept
	if Input.is_action_just_pressed("ui_accept"):
		buttons[selected_index].emit_signal("pressed")

# Atualiza o estado visual do botão selecionado
func update_button_selection():
	for i in range(buttons.size()):
		if i == selected_index:
			buttons[i].grab_focus()  # Dá foco ao botão selecionado
			buttons[i].add_theme_color_override("font_color", Color(1, 1, 0))  # Destaque no botão selecionado
		else:
			buttons[i].add_theme_color_override("font_color", Color(1, 1, 1))  # Cor padrão para os outros botões
