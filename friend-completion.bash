#!/usr/bin/env bash
# friend-li tab completion for bash and zsh

_fli_completions() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  local prev="${COMP_WORDS[COMP_CWORD-1]}"

  local commands="hatch status feed pet play train rename sprite animate card advice preview reroll version help"
  local stats="DEBUGGING PATIENCE CHAOS WISDOM SNARK"

  case "${prev}" in
    train)
      COMPREPLY=($(compgen -W "${stats}" -- "${cur}"))
      return
      ;;
    fli)
      COMPREPLY=($(compgen -W "${commands}" -- "${cur}"))
      return
      ;;
  esac

  COMPREPLY=($(compgen -W "${commands}" -- "${cur}"))
}

complete -F _fli_completions fli

# zsh compatibility
if [[ -n "${ZSH_VERSION:-}" ]]; then
  autoload -U +X bashcompinit && bashcompinit
  complete -F _fli_completions fli
fi
