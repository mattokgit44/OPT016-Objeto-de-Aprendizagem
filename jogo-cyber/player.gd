# Player.gd
extends CharacterBody2D

const SPEED = 200.0

func _physics_process(delta: float) -> void:
	# Pega o input de 4 direções (Cima, Baixo, Esquerda, Direita)
	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	# Define a velocidade baseada na direção
	if direction:
		velocity = direction.normalized() * SPEED
	else:
		# --- CORREÇÃO AQUI ---
		# O player irá desacelerar suavemente até parar.
		# Note o "velocity." no início, que chama o método correto.
		velocity = velocity.move_toward(Vector2.ZERO, SPEED * delta)

	move_and_slide()
