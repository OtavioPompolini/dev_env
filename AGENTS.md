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

## NUNCA criar `env/.local/bin`

Todo script pessoal (helper, wrapper, `exec-once` do hyprland, etc) vai em
`env/.local/scripts/`, nunca em `env/.local/bin/`.

Motivo: `~/.local/bin` é onde ficam binários instalados fora do repo (rtk,
cliamp, symlink do claude, etc — não versionados aqui). `dev-env` faz
`rm -rf` no diretório destino inteiro antes de copiar; se o repo criar
`env/.local/bin`, o `dev-env` apaga `~/.local/bin` real e destrói esses
binários. Já aconteceu uma vez. `~/.local/scripts` é dedicado só pra
scripts do repo, então é seguro de sobrescrever inteiro.

## Privilégio (sudo vs pkexec)

Comando privilegiado rodado por um agente (sem terminal interativo pra
digitar senha do sudo) deve usar `pkexec` em vez de `sudo`. `pkexec` abre um
prompt gráfico via polkit, então funciona mesmo sem TTY.

Isso só funciona com um agente polkit gráfico rodando — `runs/hyprpolkitagent`
instala `hyprpolkitagent` e `hyprland.conf` já tem `exec-once = hyprpolkitagent`.
Sem isso, `pkexec` falha (nenhum agente registrado).

Em terminal interativo normal, continua sendo `sudo`.

Essa regra também vive em `env/.claude/dev-env.md`, incluído por
`env/.claude/CLAUDE.md` (`@dev-env.md`) — copiado pra `~/.claude/` pelo
`dev-env` (`copy`, nunca `update_files`/`rm -rf`, já que `~/.claude` guarda
sessões e outras coisas não versionadas aqui) pra valer em toda sessão do
Claude Code, não só dentro deste repo.

## Uso

```bash
export DEV_ENV=$(pwd)
./dev-env          # aplica configs (destrutivo: rm -rf + cp)
./dev-env --dry     # mostra o que faria, sem aplicar
./run               # roda scripts em runs/
./run --dry         # dry-run dos runs
```

`dev-env` chama `hyprctl reload` no final.
