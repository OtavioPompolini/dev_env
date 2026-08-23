# AGENTS.md

Dotfiles repo. Fonte da verdade fica aqui, não em `~/.config` direto.

## Regra

Sempre editar configs neste projeto (`env/.config/...`, `env/.local/...`, etc),
nunca só em `~/.config` ou `~/.local`. Depois rodar `dev-env` (ou `run`) pra
copiar/instalar as mudanças pro sistema.

Se editar direto em `~/.config`, sincronizar de volta pro projeto antes de
terminar (senão próxima `dev-env` sobrescreve a edição local com a versão
antiga do repo).

## Estrutura

- `env/.config/<app>/...` → copiado pra `$XDG_CONFIG_HOME/<app>/...`
  (default `~/.config`)
- `env/.local/...` → copiado pra `~/.local/...`
- `runs/*` → scripts executáveis, disparados por `./run`
- `dev-env` → script que faz o rsync/copy real (remove diretório destino e
  copia de novo, então é destrutivo pra qualquer coisa não versionada lá)

## Uso

```bash
export DEV_ENV=$(pwd)
./dev-env          # aplica configs (destrutivo: rm -rf + cp)
./dev-env --dry     # mostra o que faria, sem aplicar
./run               # roda scripts em runs/
./run --dry         # dry-run dos runs
```

`dev-env` chama `hyprctl reload` no final.
