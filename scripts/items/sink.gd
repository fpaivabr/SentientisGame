extends Area2D

@onready var dialog_box = $"../../DialogBox"  # Caminho relativo para o DialogBox na cena

# Função chamada quando o player entra na área de interação
func _on_body_entered(body):
	if body.name == "Player":
		print("Player está interagindo com a pia.")
		show_dialog()

# Exibe o diálogo
func show_dialog():
	var message = "A pia está limpa, mas a torneira parece solta. O que deseja fazer?"
	var options = ["Abrir a torneira", "Examinar", "Cancelar"]  # Opções do diálogo
	dialog_box.show_message(message, options, _on_option_selected)

# Função chamada quando uma opção do diálogo é selecionada
func _on_option_selected(selected_option: String):
	if selected_option == "Abrir a torneira":
		print("O player abriu a torneira e ouviu um barulho estranho.")
		# Adicione lógica para a ação de abrir a torneira
	elif selected_option == "Examinar":
		print("O player examinou a pia e percebeu algo fora do normal.")
		# Adicione lógica para examinar o objeto
	elif selected_option == "Cancelar":
		print("O player cancelou a interação com a pia.")
