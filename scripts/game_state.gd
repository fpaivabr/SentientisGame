extends Node

# Controle do progresso da história em partes
var story_events: Dictionary = {
	"part_1": {
		"dog": {
			"text": "Fazendo bagunça no laboratório de novo, Gunter?",
			"options": ["Fazer Carinho", "Chamar Atenção"],
			"responses": {
				"Fazer Carinho": "O cachorro faz barulho de choramingar.",
				"Chamar Atenção": "O cachorro faz barulho de rosnar."
			}
		},
		"robot": {
			"text": "O robô está parado, aguardando o código final.",
			"options": []
		},
		"pc": {
			"text": "O que você quer fazer no PC?",
			"options": ["Escrever Código", "Jogar Bloodborne 3 Remake", "Y Videos"],
			"responses": {
				"Escrever Código": "Será que eu preciso deixar a IA mais lógica ou com mais empatia?",
				"Jogar Bloodborne 3 Remake": "Agora não! Você tem muito o que fazer.",
				"Y Videos": "Agora não! Você tem muito o que fazer."
			}
		}
	},
	"part_2": {
		"robot": {
			"text": "Alerta!! Problemas na bateria.",
			"options": ["Ativar com Risco", "Ajustar Energia", "Buscar Nova Fonte"],
			"responses": {
				"Ativar com Risco": "Você ativou o robô, mesmo com o risco!",
				"Ajustar Energia": "Energia ajustada com sucesso.",
				"Buscar Nova Fonte": "Você decidiu buscar uma nova fonte de energia."
			}
		}
	}
}

# Controle da parte atual da história
var current_part: String = "part_1"

# Controle da posição do player
var player_position: Vector2 = Vector2.ZERO

# Controle para identificar a primeira cena carregada
var is_first_scene: bool = true
