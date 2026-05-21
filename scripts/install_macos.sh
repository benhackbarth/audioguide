#!/usr/bin/env bash
set -euo pipefail

SCRIPT_NAME="$(basename "$0")"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
VENV_DIR="${REPO_ROOT}/.venv"
INSTALL_BREW=0
SKIP_BREW=0
INSTALL_EXTRAS=0
PACKAGE_APP=0
BREW_BIN=""
PYTHON_BIN=""

usage() {
  cat <<USAGE
AudioGuide macOS installer

Usage:
  ${SCRIPT_NAME} [options]

Options:
  --venv PATH             Virtual environment path (default: ${VENV_DIR})
  --python PATH           Python executable to use (default: Homebrew python3.12, then python3)
  --install-homebrew      Install Homebrew automatically if it is not already installed
  --no-brew               Skip Homebrew package installation (csound/ffmpeg/python)
  --with-analysis-extras  Install optional Python packages used by advanced examples/features
                          (scipy, librosa, scikit-learn, soundfile, matplotlib, pyaaf2)
  --package-app           Also install PyInstaller and build dist/AudioGuide GUI.app
  -h, --help              Show this help message

Examples:
  scripts/install_macos.sh
  scripts/install_macos.sh --install-homebrew --with-analysis-extras
  scripts/install_macos.sh --package-app
USAGE
}

log() {
  printf '\033[1;34m==>\033[0m %s\n' "$*"
}

warn() {
  printf '\033[1;33mWarning:\033[0m %s\n' "$*" >&2
}

fail() {
  printf '\033[1;31mError:\033[0m %s\n' "$*" >&2
  exit 1
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --venv)
      [[ $# -ge 2 ]] || fail "--venv requires a path"
      VENV_DIR="$2"
      shift 2
      ;;
    --python)
      [[ $# -ge 2 ]] || fail "--python requires an executable path"
      PYTHON_BIN="$2"
      shift 2
      ;;
    --install-homebrew)
      INSTALL_BREW=1
      shift
      ;;
    --no-brew)
      SKIP_BREW=1
      shift
      ;;
    --with-analysis-extras)
      INSTALL_EXTRAS=1
      shift
      ;;
    --package-app)
      PACKAGE_APP=1
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      fail "Unknown option: $1"
      ;;
  esac
done

[[ "$(uname -s)" == "Darwin" ]] || fail "This installer is tailored for macOS."
[[ -f "${REPO_ROOT}/agConcatenate.py" ]] || fail "Could not find AudioGuide repository root."

cd "${REPO_ROOT}"
log "Setting up AudioGuide from ${REPO_ROOT}"
log "Detected $(uname -m) Mac running macOS $(sw_vers -productVersion)"

if [[ ${SKIP_BREW} -eq 1 && ${INSTALL_BREW} -eq 1 ]]; then
  fail "Use either --no-brew or --install-homebrew, not both."
fi

if command -v brew >/dev/null 2>&1; then
  BREW_BIN="$(command -v brew)"
elif [[ -x /opt/homebrew/bin/brew ]]; then
  BREW_BIN="/opt/homebrew/bin/brew"
elif [[ -x /usr/local/bin/brew ]]; then
  BREW_BIN="/usr/local/bin/brew"
fi

if [[ -z "${BREW_BIN}" && ${SKIP_BREW} -eq 0 ]]; then
  if [[ ${INSTALL_BREW} -eq 1 ]]; then
    log "Installing Homebrew"
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    if [[ -x /opt/homebrew/bin/brew ]]; then
      BREW_BIN="/opt/homebrew/bin/brew"
    elif [[ -x /usr/local/bin/brew ]]; then
      BREW_BIN="/usr/local/bin/brew"
    else
      fail "Homebrew installation completed, but brew was not found."
    fi
  else
    warn "Homebrew was not found. Install it from https://brew.sh or rerun with --install-homebrew."
    warn "Continuing without Homebrew packages; csound and ffmpeg may be unavailable."
    SKIP_BREW=1
  fi
fi

if [[ ${SKIP_BREW} -eq 0 ]]; then
  log "Installing macOS command-line dependencies with Homebrew"
  "${BREW_BIN}" update
  "${BREW_BIN}" install python@3.12 csound ffmpeg libsndfile

  if [[ -z "${PYTHON_BIN}" ]]; then
    PYTHON_BIN="$(${BREW_BIN} --prefix python@3.12)/bin/python3.12"
  fi
fi

if [[ -z "${PYTHON_BIN}" ]]; then
  if command -v python3.12 >/dev/null 2>&1; then
    PYTHON_BIN="$(command -v python3.12)"
  elif command -v python3 >/dev/null 2>&1; then
    PYTHON_BIN="$(command -v python3)"
  else
    fail "Python 3 was not found. Install Python 3.10+ or rerun without --no-brew."
  fi
fi

log "Using Python at ${PYTHON_BIN}"
"${PYTHON_BIN}" - <<'PY'
import sys
if sys.version_info < (3, 10):
    raise SystemExit(f"Python 3.10 or newer is required; found {sys.version.split()[0]}")
PY

log "Creating virtual environment at ${VENV_DIR}"
"${PYTHON_BIN}" -m venv "${VENV_DIR}"
# shellcheck disable=SC1091
source "${VENV_DIR}/bin/activate"

log "Installing Python packages"
python -m pip install --upgrade pip setuptools wheel
python -m pip install numpy
python -m pip install -r requirements-gui.txt

log "Installing command-line launcher"
cat > "${VENV_DIR}/bin/audioguide-gui-render" <<EOF
#!/usr/bin/env bash
cd "${REPO_ROOT}"
exec "${VENV_DIR}/bin/python" -m audioguide_gui.cli "\$@"
EOF
chmod +x "${VENV_DIR}/bin/audioguide-gui-render"
cat > "${VENV_DIR}/bin/audioguide-gui-export-keepers" <<EOF
#!/usr/bin/env bash
cd "${REPO_ROOT}"
exec "${VENV_DIR}/bin/python" "${REPO_ROOT}/scripts/audioguide_gui_export_keepers.py" "\$@"
EOF
chmod +x "${VENV_DIR}/bin/audioguide-gui-export-keepers"
cat > "${VENV_DIR}/bin/audioguide-gui-export-assembly" <<EOF
#!/usr/bin/env bash
cd "${REPO_ROOT}"
exec "${VENV_DIR}/bin/python" "${REPO_ROOT}/scripts/audioguide_gui_export_assembly.py" "\$@"
EOF
chmod +x "${VENV_DIR}/bin/audioguide-gui-export-assembly"
cat > "${VENV_DIR}/bin/audioguide-gui-export-ableton" <<EOF
#!/usr/bin/env bash
cd "${REPO_ROOT}"
exec "${VENV_DIR}/bin/python" "${REPO_ROOT}/scripts/audioguide_gui_export_ableton.py" "\$@"
EOF
chmod +x "${VENV_DIR}/bin/audioguide-gui-export-ableton"

if [[ ${INSTALL_EXTRAS} -eq 1 ]]; then
  log "Installing optional analysis/DAW/export extras"
  python -m pip install scipy librosa scikit-learn soundfile matplotlib pyaaf2
fi

if [[ ${PACKAGE_APP} -eq 1 ]]; then
  log "Installing PyInstaller and building macOS app bundle"
  python -m pip install pyinstaller
  pyinstaller --clean --noconfirm packaging/audioguide_gui_macos.spec
fi

log "Verifying installation"
python - <<'PY'
import importlib.util
import numpy
import audioguide
missing = [name for name in ("PySide6", "yaml") if importlib.util.find_spec(name) is None]
if missing:
    raise SystemExit(f"Missing required package(s): {', '.join(missing)}")
print(f"AudioGuide {audioguide.__version__} import OK")
print(f"NumPy {numpy.__version__} import OK")
print("PySide6 import OK")
print("PyYAML import OK")
PY

for tool in csound ffmpeg; do
  if command -v "${tool}" >/dev/null 2>&1; then
    log "Found ${tool}: $(command -v "${tool}")"
  else
    warn "${tool} was not found on PATH. Install it with Homebrew if your workflow needs it."
  fi
done

cat <<DONE

AudioGuide setup is complete.

Next steps:
  source "${VENV_DIR}/bin/activate"
  python -m audioguide_gui

CLI example:
  audioguide-gui-render examples/gui_config.yaml --print-options
  audioguide-gui-render examples/gui_config.yaml --render
  audioguide-gui-export-keepers output/transmissions-render-manifest.json
  audioguide-gui-export-assembly output/keepers/keepers-manifest.json
  audioguide-gui-export-ableton output/keepers/keepers-manifest.json
  python agConcatenate.py examples/01-simplest.py
DONE
