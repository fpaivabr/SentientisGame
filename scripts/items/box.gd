extends Area2D

@onready var dialog_box = $"../../DialogBox"  # Caminho relativo para o DialogBox na cena

# Função chamada quando o player entra na área de interação
func _on_body_entered(body):
	if body.name == "Player":
		print("Player está interagindo com a caixa.")
		show_dialog()

# Exibe o diálogo
func show_dialog():
	var message = "Uma caixa velha está aqui. O que deseja fazer?"
	var options = ["Abrir", "Mover", "Cancelar"]  # Opções do diálogo
	dialog_box.show_message(message, options, _on_option_selected)

# Função chamada quando uma opção do diálogo é selecionada
func _on_option_selected(selected_option: String):
	if selected_option == "Abrir":
		print("O player abriu a caixa.")
		# Adicione lógica para abrir a caixa
	elif selected_option == "Mover":
		print("O player tentou mover a caixa.")
		# Adicione lógica para mover a caixa
	elif selected_option == "Cancelar":
		print("O player cancelou a interação com a caixa.")


func _on_body_exited(body: Node2D) -> void:
	pass # Replace with function body.
