# Neovim Configuration

Personal Neovim configuration using Lazy.nvim plugin manager with modular Lua-based structure.

## Structure

- `init.lua` - Entry point with VSCode detection
- `lua/config/` - Core configuration modules
- `lua/plugins/` - Individual plugin configurations
- `ftplugin/` - Filetype-specific settings

## Key Features

- Leader key: comma (`,`)
- LSP support via Mason
- Treesitter syntax highlighting
- Telescope fuzzy finder
- Git integration (Fugitive, Gitsigns)
- Terminal integration (ToggleTerm)
- Python debugging support
- Claude Code integration

## Installation

1. Clone to your Neovim config directory
2. Run `:Lazy sync` to install plugins
3. Run `:checkhealth` to verify setup

## TODO

- Add more language servers via Mason
- Configure additional Treesitter parsers for new languages
- Set up more DAP configurations for debugging
- Review and optimize plugin lazy loading
- Add custom snippets for common patterns
- Configure additional telescope pickers
- Set up project-specific configurations
- Review keybindings for conflicts
- Add more completion sources
- Configure additional linters and formatters
