# my-bashrc

A collection of custom Bash configuration scripts, aliases, and prompt enhancements to improve your terminal experience.

<img width="644" height="93" alt="image" src="https://github.com/user-attachments/assets/7d9aa6c6-8e36-4fdb-af03-7b3d40d769ef" />


## Features

- **Custom Git Prompt:**  
  Shows current Git branch, status, and directory info with colors and icons.
- **Directory and File Counters:**  
  Displays the number of folders, files, and symlinks in the current directory.
- **Kubernetes Autocompletion:**  
  Enables bash completion for `kubectl` commands.
- **Handy Aliases:**  
  Shortcuts for common `kubectl` and `terragrunt` commands, and Docker cleanup.

## Quick Setup

You can use the following script to quickly set up your bashrc configuration:

## bash

```bash
curl -o ~/my-bashrc-remote.sh https://raw.githubusercontent.com/fsrodriguezm/my-bashrc/refs/heads/main/bashrc.sh
cat ~/my-bashrc-remote.sh >> ~/.bashrc
source ~/.bashrc
```

## zsh (mac)

```
# --- macOS zsh Powerline Prompt Installer ---
set -e

# 1) Homebrew
if ! command -v brew >/dev/null 2>&1; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# 2) iTerm2 + Nerd Fonts (Meslo)
brew update
brew install --cask iterm2
brew tap homebrew/cask-fonts
brew install --cask font-meslo-lg-nerd-font

# 3) Fetch your prompt file
PROMPT_URL="https://raw.githubusercontent.com/fsrodriguezm/my-bashrc/refs/heads/main/prompt_powerline_simple.zsh"
curl -fsSL "$PROMPT_URL" -o "$HOME/prompt_powerline_simple.zsh"

# 4) Ensure zsh is default shell (optional)
if [ "$SHELL" != "/bin/zsh" ] && command -v zsh >/dev/null 2>&1; then
  chsh -s /bin/zsh || true
fi

# 5) Append to ~/.zshrc idempotently
add_line() {
  grep -Fqx "$1" "$HOME/.zshrc" 2>/dev/null || echo "$1" >> "$HOME/.zshrc"
}
add_line ""
add_line "# --- Powerline prompt (fsrodriguezm) ---"
add_line "export USE_POWERLINE=true"
add_line "source \$HOME/prompt_powerline_simple.zsh"

# 6) Reload shell
echo "Done. Opening iTerm2 and reloading zsh..."
open -a iTerm
exec zsh -l
```

## Requirements

- Bash shell
- `curl` (for downloading git prompt script)
- `kubectl` (for Kubernetes completion and aliases)
- `terragrunt` (for terragrunt aliases)
- `docker` (for Docker prune alias)

## Customization

Feel free to edit `bashrc.sh` to add your own aliases, functions, or prompt tweaks.
