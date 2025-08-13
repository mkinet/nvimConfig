# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Common Commands

### Plugin Management
- `:Lazy` - Open Lazy.nvim plugin manager interface
- `:Lazy sync` - Sync plugins (install/update/clean)
- `:TSUpdate` - Update Treesitter parsers

### LSP & Development
- `:Mason` - Open Mason LSP installer interface
- `:LspInfo` - Show LSP client information
- `:checkhealth` - Run Neovim health checks for plugins and configuration

### Plugin-Specific Commands
- `:Telescope find_files` - Find files with fuzzy search
- `:NvimTreeToggle` - Toggle file explorer
- `:Glow` - Preview markdown files
- `:ToggleTerm` - Toggle terminal

## Configuration Architecture

This Neovim configuration follows a modular Lua-based structure using Lazy.nvim as the plugin manager:

### Core Structure
- `init.lua` - Entry point that detects VSCode and loads appropriate config
- `lua/config/` - Core configuration modules
  - `options.lua` - Vim options and settings
  - `keymaps.lua` - Custom key mappings (leader key: `,`)
  - `lazy.lua` - Lazy.nvim plugin manager setup
  - `vscode.lua` - VSCode-specific configuration
- `lua/plugins/` - Individual plugin configurations as separate modules
- `ftplugin/` - Filetype-specific settings (e.g., Java)

### Key Features
- **Leader Key**: Comma (`,`) for custom commandsU
- **Plugin Manager**: Lazy.nvim with lazy loading
- **LSP**: Full LSP support via Mason, nvim-lspconfig
- **Completion**: nvim-cmp with multiple sources
- **Syntax**: Treesitter with auto-tag support
- **Git Integration**: Fugitive, Gitsigns
- **File Navigation**: Telescope, nvim-tree
- **Terminal**: ToggleTerm integration
- **Python Support**: DAP debugging, virtual environment selection
- **Claude Code**: Native claude-code.nvim plugin integration

### Development Workflow
When modifying this configuration:
1. Edit plugin files in `lua/plugins/` for specific functionality
2. Use `:Lazy sync` to install/update plugins after changes
3. Run `:checkhealth` to verify configuration integrity
4. Test in both regular Neovim and VSCode contexts

### Plugin Management Philosophy
Each plugin is configured as a separate module in `lua/plugins/` with lazy loading based on events, commands, or filetypes. The configuration prioritizes performance through deferred loading and minimal startup impact.

### Python REPL Setup
Currently using Vigemus/iron.nvim for Python REPL integration. See `lua/plugins/python-repl-migration.md` for future upgrade considerations.
