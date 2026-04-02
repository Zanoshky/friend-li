#!/usr/bin/env bash
set -euo pipefail

CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FRIEND_HOME="${HOME}/.friend-li"
BIN_DIR="${HOME}/.local/bin"
VERSION_FILE="${FRIEND_HOME}/.version"
FORCE=false

for arg in "$@"; do
  case "$arg" in
    -f|--force) FORCE=true ;;
  esac
done

echo ""
echo -e "${CYAN}[fli]${NC} ${GREEN}installer${NC}"
echo ""

CURRENT_HASH=$(git -C "${REPO_DIR}" rev-parse --short HEAD 2>/dev/null || echo "dev")

if [[ -f "${VERSION_FILE}" ]] && [[ "${FORCE}" == "false" ]]; then
  INSTALLED_HASH=$(cat "${VERSION_FILE}")
  if [[ "${INSTALLED_HASH}" == "${CURRENT_HASH}" ]]; then
    echo -e "${GREEN}[fli]${NC} Already installed at version ${CYAN}${CURRENT_HASH}${NC}."
    echo -e "${YELLOW}[fli]${NC} Run ${CYAN}./install.sh -f${NC} to force reinstall."
    exit 0
  fi
  echo -e "${CYAN}[fli]${NC} Updating: ${YELLOW}${INSTALLED_HASH}${NC} -> ${GREEN}${CURRENT_HASH}${NC}"
fi

echo -e "${CYAN}[fli]${NC} Installing to ${FRIEND_HOME}..."
mkdir -p "${FRIEND_HOME}"
cp "${REPO_DIR}/fli" "${FRIEND_HOME}/fli"
cp "${REPO_DIR}/sprites.sh" "${FRIEND_HOME}/sprites.sh"
if [[ -f "${REPO_DIR}/advice.sh" ]]; then
  cp "${REPO_DIR}/advice.sh" "${FRIEND_HOME}/advice.sh"
fi
if [[ -f "${REPO_DIR}/friend-completion.bash" ]]; then
  cp "${REPO_DIR}/friend-completion.bash" "${FRIEND_HOME}/friend-completion.bash"
fi
chmod 755 "${FRIEND_HOME}/fli"
echo "${CURRENT_HASH}" > "${VERSION_FILE}"

# Fix SCRIPT_DIR in installed copy to point to FRIEND_HOME
sed -i.bak "s|SCRIPT_DIR=.*|SCRIPT_DIR=\"${FRIEND_HOME}\"|" "${FRIEND_HOME}/fli"
rm -f "${FRIEND_HOME}/fli.bak"

mkdir -p "${BIN_DIR}"
ln -sf "${FRIEND_HOME}/fli" "${BIN_DIR}/fli"

# Shell completions
COMPLETION_LINE="[ -f ~/.friend-li/friend-completion.bash ] && source ~/.friend-li/friend-completion.bash"
for rc in "${HOME}/.bashrc" "${HOME}/.zshrc"; do
  if [[ -f "${rc}" ]] && ! grep -qF "friend-completion.bash" "${rc}"; then
    echo "" >> "${rc}"
    echo "# friend-li CLI completions" >> "${rc}"
    echo "${COMPLETION_LINE}" >> "${rc}"
    echo -e "${GREEN}[fli]${NC} Added completions to $(basename "${rc}")"
  fi
done

if ! echo "$PATH" | tr ':' '\n' | grep -q "^${BIN_DIR}$"; then
  echo ""
  echo -e "${RED}[fli]${NC} ${BIN_DIR} is not in your PATH."
  echo -e "${RED}[fli]${NC} Add this to your shell profile:"
  echo ""
  echo "  export PATH=\"\${HOME}/.local/bin:\${PATH}\""
  echo ""
else
  echo -e "${GREEN}[fli]${NC} Installed ${CYAN}${CURRENT_HASH}${NC}. Run ${CYAN}fli hatch${NC} to get started."
fi
echo ""
