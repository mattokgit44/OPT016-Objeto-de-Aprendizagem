from flask import Flask, request, jsonify
import subprocess
import shlex

# Cria o servidor Flask
app = Flask(__name__)

# O "container_alvo" que nosso jogo vai controlar
# É o mesmo nome que usamos no 'docker run'
CONTAINER_NOME = "meu-terminal-jogo"

# Esta é a URL que o Godot vai chamar (ex: /api/command)
@app.route("/api/command", methods=["POST"])
def handle_command():
    
    # 1. Pega o JSON enviado pelo Godot
    data = request.json
    command_string = data.get("command", "") # Pega o comando (ex: "ls -l")

    if not command_string:
        return "Erro: Nenhum comando recebido.", 400

    # --- AVISO DE SEGURANÇA ---
    # Isto é perigoso! Estamos executando qualquer coisa que o usuário digitar.
    # Para um protótipo, isso é OK, mas NUNCA faça isso em produção.
    # Não estamos "sanitizando" nada.
    
    # 2. Constrói o comando 'docker exec' completo
    # Nós usamos 'sh -c' para permitir que o usuário digite "ls -l" ou "cat arquivo.txt"
    docker_command = [
        "docker", 
        "exec", 
        CONTAINER_NOME, 
        "sh", 
        "-c", 
        command_string 
    ]

    # 3. Executa o comando no Docker e captura a saída
    try:
        result = subprocess.run(
            docker_command, 
            capture_output=True, 
            text=True, 
            timeout=5 # Define um tempo limite de 5 segundos
        )
        
        # 4. Combina a saída padrão (stdout) e a saída de erro (stderr)
        output = result.stdout + result.stderr
        
        # 5. Retorna a saída como texto puro para o Godot
        return output
        
    except Exception as e:
        # Pega erros (ex: comando demorou demais, etc.)
        return f"Erro no servidor: {str(e)}", 500

# Roda o servidor na porta 8080 (mesma porta do script do Godot)
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8081)
