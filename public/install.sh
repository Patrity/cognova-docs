#!/bin/sh
# Cognova installer
# Usage: curl -fsSL https://cognova.dev/install.sh | sh
# Flags: --yes (-y) auto-confirm, --skip-init skip cognova init
set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
DIM='\033[2m'
RESET='\033[0m'

AUTO_YES=false
SKIP_INIT=false
PLATFORM=""
PKG_MANAGER=""
NEED_SUDO=""

for arg in "$@"; do
  case "$arg" in
    --yes|-y) AUTO_YES=true ;;
    --skip-init) SKIP_INIT=true ;;
    --help|-h)
      printf "Usage: curl -fsSL https://cognova.dev/install.sh | sh\n\n"
      printf "Flags:\n"
      printf "  --yes, -y      Auto-confirm all prompts\n"
      printf "  --skip-init    Install prerequisites only, skip cognova init\n"
      printf "  --help, -h     Show this help\n"
      exit 0
      ;;
  esac
done

info()    { printf "${BLUE}info${RESET}  %s\n" "$1"; }
ok()      { printf "${GREEN}  ok${RESET}  %s\n" "$1"; }
warn()    { printf "${YELLOW}warn${RESET}  %s\n" "$1"; }
fail()    { printf "${RED}fail${RESET}  %s\n" "$1"; exit 1; }
step()    { printf "\n${BOLD}${CYAN}▸ %s${RESET}\n" "$1"; }

confirm() {
  if [ "$AUTO_YES" = true ]; then return 0; fi
  printf "${YELLOW}?${RESET} %s ${DIM}[Y/n]${RESET} " "$1"
  read -r reply
  case "$reply" in
    [nN]*) return 1 ;;
    *) return 0 ;;
  esac
}

command_exists() { command -v "$1" >/dev/null 2>&1; }

version_ge() {
  actual_major=$(echo "$1" | sed 's/^v//' | cut -d. -f1)
  required_major="$2"
  [ "$actual_major" -ge "$required_major" ] 2>/dev/null
}

run_sudo() {
  if [ -n "$NEED_SUDO" ]; then
    sudo "$@"
  else
    "$@"
  fi
}

printf "\n"
printf "${BOLD}${CYAN}  ╭──────────────────────────────────────╮${RESET}\n"
printf "${BOLD}${CYAN}  │                                      │${RESET}\n"
printf "${BOLD}${CYAN}  │          ${RESET}${BOLD}Cognova Installer${CYAN}          │${RESET}\n"
printf "${BOLD}${CYAN}  │                                      │${RESET}\n"
printf "${BOLD}${CYAN}  ╰──────────────────────────────────────╯${RESET}\n"
printf "\n"
printf "  ${DIM}Works on macOS, Linux, and WSL.${RESET}\n"
printf "  ${DIM}Installs prerequisites, then runs cognova init.${RESET}\n"
printf "\n"

# ─── Platform detection ─────────────────────────────────
step "Detecting platform"

OS="$(uname -s)"
ARCH="$(uname -m)"

case "$OS" in
  Darwin)
    PLATFORM="macos"
    ok "macOS ($ARCH)"
    ;;
  Linux)
    if [ -f /proc/version ] && grep -qi microsoft /proc/version 2>/dev/null; then
      PLATFORM="wsl"
      ok "WSL ($ARCH)"
    else
      PLATFORM="linux"
      ok "Linux ($ARCH)"
    fi
    ;;
  MINGW*|MSYS*|CYGWIN*)
    fail "Native Windows is not supported. Install WSL first: https://learn.microsoft.com/en-us/windows/wsl/install"
    ;;
  *)
    fail "Unsupported platform: $OS"
    ;;
esac

# ─── Package manager detection ──────────────────────────
step "Detecting package manager"

if [ "$PLATFORM" = "macos" ]; then
  if command_exists brew; then
    PKG_MANAGER="brew"
    ok "Homebrew"
  else
    info "Homebrew not found — installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    if [ -f /opt/homebrew/bin/brew ]; then
      eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [ -f /usr/local/bin/brew ]; then
      eval "$(/usr/local/bin/brew shellenv)"
    fi
    PKG_MANAGER="brew"
    ok "Homebrew (just installed)"
  fi
else
  if command_exists apt-get; then
    PKG_MANAGER="apt"
    ok "apt (Debian/Ubuntu)"
  elif command_exists dnf; then
    PKG_MANAGER="dnf"
    ok "dnf (Fedora/RHEL)"
  elif command_exists pacman; then
    PKG_MANAGER="pacman"
    ok "pacman (Arch)"
  else
    fail "No supported package manager found (apt, dnf, or pacman required)"
  fi
  if [ "$(id -u)" -ne 0 ]; then
    NEED_SUDO="1"
  fi
fi

# ─── Python 3 ───────────────────────────────────────────
step "Checking Python 3"

install_python() {
  info "Installing Python 3..."
  case "$PKG_MANAGER" in
    brew)   brew install python3 ;;
    apt)    run_sudo apt-get update -qq && run_sudo apt-get install -y -qq python3 ;;
    dnf)    run_sudo dnf install -y -q python3 ;;
    pacman) run_sudo pacman -S --noconfirm python ;;
  esac
}

if command_exists python3; then
  PY_VERSION="$(python3 --version 2>&1)"
  ok "$PY_VERSION"
elif command_exists python; then
  PY_VERSION="$(python --version 2>&1)"
  case "$PY_VERSION" in
    *"3."*)
      warn "Found $PY_VERSION as 'python' but 'python3' command missing"
      info "Creating python3 symlink..."
      PYTHON_PATH="$(command -v python)"
      run_sudo ln -sf "$PYTHON_PATH" /usr/local/bin/python3
      ok "$PY_VERSION (symlinked to python3)"
      ;;
    *)
      warn "Found Python 2 — Python 3 is required"
      if confirm "Install Python 3?"; then
        install_python
        ok "$(python3 --version 2>&1)"
      else
        fail "Python 3 is required for Cognova skills and hooks"
      fi
      ;;
  esac
else
  warn "Python 3 not found"
  if confirm "Install Python 3?"; then
    install_python
    ok "$(python3 --version 2>&1)"
  else
    fail "Python 3 is required for Cognova skills and hooks"
  fi
fi

# ─── Node.js 22+ ────────────────────────────────────────
step "Checking Node.js"

REQUIRED_NODE_MAJOR=22

install_node() {
  info "Installing Node.js $REQUIRED_NODE_MAJOR..."
  case "$PKG_MANAGER" in
    brew)
      brew install "node@$REQUIRED_NODE_MAJOR"
      brew link --overwrite "node@$REQUIRED_NODE_MAJOR" 2>/dev/null || true
      ;;
    apt)
      info "Setting up NodeSource repository..."
      curl -fsSL "https://deb.nodesource.com/setup_${REQUIRED_NODE_MAJOR}.x" | run_sudo bash -
      run_sudo apt-get install -y -qq nodejs
      ;;
    dnf)
      info "Setting up NodeSource repository..."
      curl -fsSL "https://rpm.nodesource.com/setup_${REQUIRED_NODE_MAJOR}.x" | run_sudo bash -
      run_sudo dnf install -y -q nodejs
      ;;
    pacman)
      run_sudo pacman -S --noconfirm nodejs npm
      ;;
  esac
}

if command_exists node; then
  NODE_VERSION="$(node --version 2>&1)"
  if version_ge "$NODE_VERSION" "$REQUIRED_NODE_MAJOR"; then
    ok "Node.js $NODE_VERSION"
  else
    warn "Node.js $NODE_VERSION found — version $REQUIRED_NODE_MAJOR+ required"
    if confirm "Install Node.js $REQUIRED_NODE_MAJOR?"; then
      install_node
      ok "Node.js $(node --version 2>&1)"
    else
      fail "Node.js >= $REQUIRED_NODE_MAJOR is required"
    fi
  fi
else
  warn "Node.js not found"
  if confirm "Install Node.js $REQUIRED_NODE_MAJOR?"; then
    install_node
    ok "Node.js $(node --version 2>&1)"
  else
    fail "Node.js >= $REQUIRED_NODE_MAJOR is required"
  fi
fi

# ─── pnpm ───────────────────────────────────────────────
step "Checking pnpm"

if command_exists pnpm; then
  ok "pnpm $(pnpm --version 2>&1)"
else
  warn "pnpm not found"
  info "Installing pnpm via corepack..."
  if command_exists corepack; then
    run_sudo corepack enable
    corepack prepare pnpm@latest --activate 2>/dev/null || true
    if command_exists pnpm; then
      ok "pnpm $(pnpm --version 2>&1) (via corepack)"
    else
      info "Corepack failed, falling back to npm..."
      npm install -g pnpm
      ok "pnpm $(pnpm --version 2>&1) (via npm)"
    fi
  else
    npm install -g pnpm
    ok "pnpm $(pnpm --version 2>&1) (via npm)"
  fi
fi

# ─── Docker (optional) ─────────────────────────────────
step "Checking Docker (optional)"

install_docker() {
  case "$PLATFORM" in
    macos)
      info "Installing Docker Desktop via Homebrew..."
      brew install --cask docker
      info "Docker Desktop installed — open it from Applications to finish setup"
      ;;
    linux|wsl)
      info "Installing Docker Engine..."
      if [ "$PKG_MANAGER" = "apt" ]; then
        run_sudo apt-get update -qq
        run_sudo apt-get install -y -qq docker.io docker-compose-plugin
      elif [ "$PKG_MANAGER" = "dnf" ]; then
        run_sudo dnf install -y -q docker docker-compose-plugin
      elif [ "$PKG_MANAGER" = "pacman" ]; then
        run_sudo pacman -S --noconfirm docker docker-compose
      fi
      run_sudo systemctl enable --now docker 2>/dev/null || true
      if [ -n "$NEED_SUDO" ]; then
        run_sudo usermod -aG docker "$(whoami)" 2>/dev/null || true
        info "Added $(whoami) to docker group (log out and back in to take effect)"
      fi
      ;;
  esac
}

if command_exists docker; then
  ok "Docker available (for local PostgreSQL)"
else
  info "Docker not found — needed only for local PostgreSQL"
  if confirm "Install Docker? (skip to use a remote database instead)"; then
    install_docker
    if command_exists docker; then
      ok "Docker installed"
    else
      warn "Docker installed but may need a restart to be available"
      info "You can still use a remote PostgreSQL during setup"
    fi
  else
    info "Skipped — the setup wizard will let you use a remote database"
  fi
fi

# ─── Install Cognova ────────────────────────────────────
step "Installing Cognova"

if command_exists cognova; then
  CURRENT_VERSION="$(cognova --version 2>&1 || echo 'unknown')"
  ok "Cognova already installed ($CURRENT_VERSION)"
  info "Checking for updates..."
  npm install -g cognova@latest 2>/dev/null
  ok "Cognova $(cognova --version 2>&1)"
else
  info "Installing cognova from npm..."
  npm install -g cognova
  ok "Cognova $(cognova --version 2>&1)"
fi

# ─── Run cognova init ───────────────────────────────────
if [ "$SKIP_INIT" = true ]; then
  printf "\n${GREEN}${BOLD}All prerequisites installed!${RESET}\n"
  printf "${DIM}Run 'cognova init' when you're ready to set up.${RESET}\n\n"
  exit 0
fi

printf "\n"
printf "${BOLD}${CYAN}──────────────────────────────────────────${RESET}\n"
printf "${BOLD}  Prerequisites ready — starting setup wizard${RESET}\n"
printf "${BOLD}${CYAN}──────────────────────────────────────────${RESET}\n"
printf "\n"

# Reattach stdin to the terminal so @clack/prompts gets a real TTY
# (when piped via curl | sh, stdin is the pipe and hits EOF)
if [ ! -t 0 ] && [ -e /dev/tty ]; then
  cognova init < /dev/tty
else
  cognova init
fi
