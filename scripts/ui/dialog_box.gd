extends CanvasLayer

@onready var dialog_label = $Label
@onready var options_container = $OptionsContainer

# Lista de diálogos já exibidos
var viewed_dialogs: Dictionary = {}

var selected_option_index = 0  # Índice da opção selecionada

# Função para mostrar o diálogo
func show_dialog(dialog_text: String, options: Array = [], dialog_id: String = ""):
	# Verifica se o diálogo já foi visto
	if dialog_id != "" and viewed_dialogs.has(dialog_id):
		print("Diálogo já visto:", dialog_id)
		return

	# Marca o diálogo como visto
	if dialog_id != "":
		viewed_dialogs[dialog_id] = true

	if dialog_label:
		dialog_label.text = dialog_text

	# Remove opções antigas
	clear_children(options_container)

	# Adiciona novas opções
	if options.size() > 0:
		for i in range(options.size()):
			var button = Button.new()
			button.text = options[i]
			button.connect("pressed", Callable(self, "_on_option_selected").bind(button.text))
			options_container.add_child(button)

		options_container.visible = true
		selected_option_index = 0  # Reseta a seleção inicial
		update_button_selection()  # Atualiza a seleção visual
	else:
		options_container.visible = false

	self.visible = true

# Atualiza a seleção visual dos botões
func update_button_selection():
	for i in range(options_container.get_child_count()):
		var button = options_container.get_child(i)
		if i == selected_option_index:
			button.grab_focus()
			button.add_theme_color_override("font_color", Color(1, 1, 0))  # Cor destaque
		else:
			button.add_theme_color_override("font_color", Color(1, 1, 1))  # Cor padrão

# Resposta à escolha do jogador
func _on_option_selected(selected_option: String):
	print("Opção selecionada:", selected_option)
	hide_dialog()

# Lida com a navegação usando as teclas
func _process(delta):
	if self.visible and options_container.visible:
		handle_navigation()

func handle_navigation():
	if Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("ui_left"):
		selected_option_index = max(selected_option_index - 1, 0)
		update_button_selection()

	if Input.is_action_just_pressed("ui_down") or Input.is_action_just_pressed("ui_right"):
		selected_option_index = min(selected_option_index + 1, options_container.get_child_count() - 1)
		update_button_selection()

	if Input.is_action_just_pressed("ui_accept"):  # Tecla Enter ou "E"
		if options_container.get_child_count() > selected_option_index:
			options_container.get_child(selected_option_index).emit_signal("pressed")

# Finaliza o diálogo
func hide_dialog():
	self.visible = false
	options_container.visible = false
	clear_children(options_container)

# Remove filhos do OptionsContainer
func clear_children(container):
	for child in container.get_children():
		child.queue_free()
