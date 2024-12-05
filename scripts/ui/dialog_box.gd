extends CanvasLayer

# Referências aos elementos do DialogBox
@onready var dialog_label = $Label
@onready var options_container = $OptionsContainer

# Função para mostrar o diálogo
func show_dialog(dialog_text: String, options: Array = []):
	if dialog_label:
		dialog_label.text = dialog_text
	else:
		print("Erro: Label do diálogo não encontrada!")

	# Limpa quaisquer opções antigas
	if options_container:
		options_container.clear_children()
	else:
		print("Erro: OptionsContainer não encontrado!")

	# Adiciona novas opções
	if options.size() > 0 and options_container:
		for option in options:
			var button = Button.new()
			button.text = option
			button.connect("pressed", Callable(self, "_on_option_selected").bind(option))
			options_container.add_child(button)
		options_container.visible = true
	else:
		options_container.visible = false

	self.visible = true  # Torna o DialogBox visível

# Função chamada ao selecionar uma opção
func _on_option_selected(selected_option: String):
	print("Opção selecionada:", selected_option)
	hide_dialog()

# Esconde o DialogBox
func hide_dialog():
	self.visible = false

# Limpa os filhos do OptionsContainer
func clear_children(container):
	for child in container.get_children():
		child.queue_free()

# Inicialização
func _ready():
	self.visible = false  # O DialogBox começa invisível
	if not dialog_label:
		print("Erro: Label do diálogo não está configurada corretamente.")
	if not options_container:
		print("Erro: OptionsContainer não está configurado corretamente.")
