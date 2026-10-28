# archive/

Tentativas antigas de infraestrutura em nuvem, mantidas apenas como
material de referencia para a oficina de Git. **Nao sao mais usadas.**

- `aws/`        - EC2 + ECR (Terraform). Abandonado por limite de conta.
- `oracle/`     - OCI VM + OCIR (Terraform). Abandonado por limite de conta.
- `ci-aws.yml`  - workflow que criava a instancia EC2.
- `OCI.yml`     - workflow que criava a VM na Oracle Cloud.

A infraestrutura ativa hoje roda **localmente** nesta maquina:

- `dev/` e `prod/` (na raiz do repo) -> Terraform que cria os tuneis
  Cloudflare e os registros DNS (`dev.intelitech.shop`, `prod.intelitech.shop`).
- `docker-compose.yml` (na raiz) -> sobe os dois containers `cloudflared`.
- O deploy da aplicacao acontece no repo `intelitech-front` via
  self-hosted runner. Veja `SETUP.md`.
