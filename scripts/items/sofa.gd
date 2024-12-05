extends Area2D

@onready var dialog_box = $"../../DialogBox"  # Caminho relativo para o DialogBox na cena

# Função chamada quando o player entra na área de interação
func _on_body_entered(body):
	if body.name == "Player":
		print("Player está interagindo com o sofá.")
		show_dialog()

# Exibe o diálogo
func show_dialog():
	var message = "Um sofá confortável, mas meio empoeirado. O que deseja fazer?"
	var options = ["Sentar", "Examinar", "Cancelar"]  # Opções do diálogo
	dialog_box.show_message(message, options, _on_option_selected)

# Função chamada quando uma opção do diálogo é selecionada
func _on_option_selected(selected_option: String):
	if selected_option == "Sentar":
		print("O player sentou no sofá.")
		# Adicione lógica para a ação de sentar
	elif selected_option == "Examinar":
		print("O player examinou o sofá.")
		# Adicione lógica para examinar o sofá
	elif selected_option == "Cancelar":
		print("O player cancelou a interação com o sofá.")
