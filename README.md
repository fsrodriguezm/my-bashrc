# my-bashrc

A collection of custom Bash configuration scripts, aliases, and prompt enhancements to improve your terminal experience.

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

```bash
curl -o ~/my-bashrc-remote.sh https://raw.githubusercontent.com/yourusername/my-bashrc/main/bashrc.sh
echo 'source ~/my-bashrc-remote.sh' >> ~/.bashrc
rm ~/my-bashrc-remote.sh
source ~/.bashrc
```

## Requirements

- Bash shell
- `curl` (for downloading git prompt script)
- `kubectl` (for Kubernetes completion and aliases)
- `terragrunt` (for terragrunt aliases)
- `docker` (for Docker prune alias)

## Customization

Feel free to edit `bashrc.sh` to add your own aliases, functions, or prompt tweaks.