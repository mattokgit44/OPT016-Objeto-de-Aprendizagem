# Mundo.gd
extends Node2D

# Pega os nós da UI para poder controlá-los
@onready var _tela_desktop: PanelContainer = $CanvasLayer/TelaDesktop
@onready var _terminal: PanelContainer = $CanvasLayer/Terminal

# Pega os nós de interação
@onready var _computador: Area2D = $Computer
@onready var _botao_terminal: Button = $CanvasLayer/TelaDesktop/VBoxContainer/BotaoTerminal


func _ready() -> void:
	# Conecta o sinal 'interagir' do computador a uma função
	_computador.interagir.connect(_on_computador_interagido)
	
	# Conecta o sinal 'pressed' do botão a outra função
	_botao_terminal.pressed.connect(_on_botao_terminal_pressionado)


# Esta função é chamada quando o Computador "grita" 'interagir'
func _on_computador_interagido() -> void:
	# Mostra a tela do desktop falso
	_tela_desktop.visible = true


# Esta função é chamada quando o botão do terminal é clicado
func _on_botao_terminal_pressionado() -> void:
	# Esconde o desktop
	_tela_desktop.visible = false
	# Mostra o terminal
	_terminal.visible = true
