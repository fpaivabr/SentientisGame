extends Area2D

@onready var dialog_box = $"../../DialogBox"  # Caminho relativo para o DialogBox na cena

# Função chamada quando o player entra na área de interação
func _on_body_entered(body):
	if body.name == "Player":
		print("Player está interagindo com o vaso sanitário.")
		show_dialog()

# Exibe o diálogo
func show_dialog():
	var message = "O vaso sanitário parece limpo, mas a descarga está meio estranha. O que deseja fazer?"
	var options = ["Usar", "Examinar", "Cancelar"]  # Opções do diálogo
	dialog_box.show_message(message, options, _on_option_selected)

# Função chamada quando uma opção do diálogo é selecionada
func _on_option_selected(selected_option: String):
	if selected_option == "Usar":
		print("O player usou o vaso sanitário.")
		# Adicione lógica para a ação de usar
	elif selected_option == "Examinar":
		print("O player examinou o vaso sanitário e percebeu algo estranho.")
		# Adicione lógica para examinar o objeto
	elif selected_option == "Cancelar":
		print("O player cancelou a interação com o vaso sanitário.")
