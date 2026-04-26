# app_vuln.py

import psycopg2
from flask import Flask, request, jsonify

app = Flask(__name__)


def get_conn():
    return psycopg2.connect(
        host="localhost",
        database="hospital_security",
        user="postgres",
        password=""
    )

# VULNERÁVEL — SQL Injection via concatenação de string


@app.route("/login", methods=["POST"])
def login():
    login = request.json.get("login", "")
    senha = request.json.get("senha", "")

    query = f"SELECT * FROM usuario_sistema WHERE login = '{login}' AND senha_hash = '{senha}'"
    print(f"[DEBUG] Query executada: {query}")

    conn = get_conn()
    cur = conn.cursor()
    cur.execute(query)
    user = cur.fetchone()
    conn.close()

    if user:
        return jsonify({"status": "ok", "perfil": user[4]})
    return jsonify({"status": "falhou"}), 401


if __name__ == "__main__":
    app.run(debug=True, port=5000)
