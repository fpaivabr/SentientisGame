extends CanvasLayer

@onready var dialog_label = $Label
@onready var options_container = $OptionsContainer

# Lista de diálogos já exibidos
var viewed_dialogs: Dictionary = {}

var selected_option_index = 0  # Índice da opção selecionada
var lines = []  # Para armazenar as linhas do diálogo
var current_line_index = 0  # Índice da linha atual

# Mostrar o diálogo
func show_dialog(dialog_text: String, options: Array = [], dialog_id: String = ""):
	# Marcar diálogo como visto
	if dialog_id != "" and viewed_dialogs.has(dialog_id):
		print("Diálogo já visto:", dialog_id)
		return

	if dialog_id != "":
		viewed_dialogs[dialog_id] = true

	dialog_label.text = dialog_text

	# Limpar opções anteriores
	clear_children(options_container)

	# Adicionar novas opções
	if options.size() > 0:
		for i in range(options.size()):
			var button = Button.new()
			button.text = options[i]
			button.focus_mode = Control.FOCUS_ALL  # Permitir foco no teclado
			button.connect("pressed", Callable(self, "_on_option_selected").bind(button.text))
			options_container.add_child(button)

		options_container.visible = true
		selected_option_index = 0
		update_button_selection()
	else:
		options_container.visible = false

	self.set_process(true)
	self.visible = true

# Atualizar seleção visual
func update_button_selection():
	for i in range(options_container.get_child_count()):
		var button = options_container.get_child(i)
		if i == selected_option_index:
			button.grab_focus()  # Garante o foco no botão selecionado
			button.add_theme_color_override("font_color", Color(1, 1, 0))  # Cor destaque
		else:
			button.add_theme_color_override("font_color", Color(1, 1, 1))  # Cor padrão

# Lidar com navegação de teclas
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

	if Input.is_action_just_pressed("ui_accept"):  # Tecla E
		select_current_option()

# Selecionar a opção atual
func select_current_option():
	if options_container.get_child_count() > selected_option_index:
		var button = options_container.get_child(selected_option_index)
		if button:
			button.emit_signal("pressed")  # Simula clique no botão
			_on_option_selected(button.text)  # Processa a seleção

# Responder à escolha do jogador
func _on_option_selected(selected_option: String):
	print("Opção selecionada:", selected_option)
	hide_dialog()

# Finalizar o diálogo
func hide_dialog():
	self.set_process(false)
	self.visible = false
	options_container.visible = false
	clear_children(options_container)

# Limpar filhos do OptionsContainer
func clear_children(container):
	for child in container.get_children():
		child.queue_free()

# Mostrar múltiplas linhas de diálogo
func show_dialog_with_lines(new_lines: Array):
	lines = new_lines
	current_line_index = 0
	self.set_process(true)
	next_line()

func next_line():
	if current_line_index < lines.size():
		dialog_label.text = lines[current_line_index]
		current_line_index += 1
	else:
		hide_dialog()
