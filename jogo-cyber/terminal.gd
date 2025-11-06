# Terminal.gd
extends PanelContainer

@onready var _input: LineEdit = $VBoxContainer/LineEdit
@onready var _historico: RichTextLabel = $VBoxContainer/RichTextLabel

func _ready() -> void:
	# Conecta o sinal de "Enter" do LineEdit
	_input.text_submitted.connect(_on_comando_submetido)
	# Foca no input quando o terminal abre
	visibility_changed.connect(func(): _input.grab_focus() if visible else null)


func _on_comando_submetido(comando: String) -> void:
	_historico.append_text("\n> %s\n" % comando)
	_input.clear()
	
	match comando.strip_edges().to_lower():
		"ls":
			_historico.append_text("documento.txt\nleia-me.md\n")
		"cat leia-me.md":
			_historico.append_text("Este é um terminal falso!\n")
		"help":
			_historico.append_text("Comandos: ls, cat, help\n")
		_:
			_historico.append_text("Comando não encontrado.\n")
	
	# Rola o texto para baixo
	_historico.scroll_to_end()
