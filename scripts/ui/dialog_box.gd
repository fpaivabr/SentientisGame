extends CanvasLayer

@onready var dialog_label = $Label
@onready var options_container = $OptionsContainer

# Lista de diálogos já exibidos
var viewed_dialogs: Dictionary = {}

var selected_option_index = 0

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
		for option in options:
			var button = Button.new()
			button.text = option
			button.connect("pressed", Callable(self, "_on_option_selected").bind(option))
			options_container.add_child(button)

		options_container.visible = true
	else:
		options_container.visible = false

	self.visible = true

# Resposta à escolha do jogador
func _on_option_selected(selected_option: String):
	print("Opção selecionada:", selected_option)
	hide_dialog()

# Finaliza o diálogo
func hide_dialog():
	self.visible = false
	options_container.visible = false
	clear_children(options_container)

# Remove filhos do OptionsContainer
func clear_children(container):
	for child in container.get_children():
		child.queue_free()
