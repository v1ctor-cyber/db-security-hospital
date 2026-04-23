# Diagrama Entidade-Relacionamento

Sistema hospitalar com foco em segurança de dados sensíveis.

```erDiagram
  PACIENTE ||--o{ CONSULTA : "realiza"
  MEDICO ||--o{ CONSULTA : "atende"
  PACIENTE ||--|| PRONTUARIO : "recebe"
  CONSULTA ||--o{ PRESCRICAO : "solicita"
  PRESCRICAO o{--|| MEDICAMENTO : "receita"
  PACIENTE o{--|| INTERNACAO : "encaminha"
  INTERNACAO o|--|| LEITO : "ocupacao"
  CONSULTA ||--o{ EXAME : "faz"
  MEDICO o|--o| USUARIO_SISTEMA : "tem"
  USUARIO_SISTEMA ||--o{ LOG_ACESSO : "monitora"
```
