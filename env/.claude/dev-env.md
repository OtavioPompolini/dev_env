# dev_env

Global notes from the `dev_env` dotfiles repo (`~/workspace/dev_env`), deployed
by its `dev-env` script so they apply in every Claude Code session on this
machine, not just when working inside that repo.

## Privilege escalation (sudo vs pkexec)

A privileged command run without an interactive terminal to type a `sudo`
password into (e.g. this agent) should use `pkexec` instead of `sudo`.
`pkexec` opens a graphical polkit prompt, so it works without a TTY.

This only works because `hyprpolkitagent` is installed and autostarted
(`dev_env`'s `runs/hyprpolkitagent`, and `exec-once = hyprpolkitagent` in
`env/.config/hypr/hyprland.conf`) to act as the polkit authentication agent.
Without an agent registered, `pkexec` just fails.

In a normal interactive terminal, keep using `sudo`.
