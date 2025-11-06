# Computador.gd
extends Area2D

# Sinal que "grita" para o mundo quando interagido
signal interagir

# Variáveis para rastrear a interação
var _can_interact: bool = false
@onready var _prompt: Label = get_node("/root/MainLevel/CanvasLayer/InteractPrompt")

func _ready() -> void:
	# Conecta os sinais da própria área (pode fazer pelo editor)
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		_can_interact = true
		_prompt.visible = true # Mostra "Pressione [E]"

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		_can_interact = false
		_prompt.visible = false # Esconde "Pressione [E]"

# Roda a cada frame, verificando o input
func _input(event: InputEvent) -> void:
	# Se o player pode interagir E pressionou a tecla...
	if _can_interact and event.is_action_pressed("interagir"):
		# Trava o input para não processar duas vezes
		get_viewport().set_input_as_handled()
		# "Grita" para o mundo!
		interagir.emit()
