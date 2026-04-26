# app_secure.py
# Versão segura — mitiga SQL Injection com queries parametrizadas

import psycopg2
import bcrypt
from flask import Flask, request, jsonify

app = Flask(__name__)

def get_conn():
    return psycopg2.connect(
        host="localhost",
        database="hospital_security",
        user="postgres",
        password=""
    )

def registrar_log(id_usuario, operacao, tabela, ip):
    conn = get_conn()
    cur = conn.cursor()
    cur.execute(
        "INSERT INTO log_acesso (id_usuario, operacao, tabela_acessada, data_hora, ip_origem) VALUES (%s, %s, %s, NOW(), %s)",
        (id_usuario, operacao, tabela, ip)
    )
    conn.commit()
    conn.close()

@app.route("/login", methods=["POST"])
def login():
    login = request.json.get("login", "")
    senha = request.json.get("senha", "")

    if not login or not senha:
        return jsonify({"status": "falhou"}), 400

    query = "SELECT * FROM usuario_sistema WHERE login = %s"

    conn = get_conn()
    cur = conn.cursor()
    cur.execute(query, (login,))
    user = cur.fetchone()
    conn.close()

    ip = request.remote_addr

    if user and bcrypt.checkpw(senha.encode('utf-8'), user[3].encode('utf-8')):
        registrar_log(user[0], "SELECT", "usuario_sistema", ip)
        return jsonify({"status": "ok", "perfil": user[4]})

    registrar_log(None, "TENTATIVA_FALHA", "usuario_sistema", ip)
    return jsonify({"status": "falhou"}), 401

if __name__ == "__main__":
    app.run(debug=True, port=5001)
