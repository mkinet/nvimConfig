# Python REPL Migration to molten-nvim

## Current Setup
Using Vigemus/iron.nvim (updated from hkupty/iron.nvim for maintenance)

## Future Migration: molten-nvim

### Why molten-nvim is superior:
- **Active Development**: 901+ stars, actively maintained by benlubas
- **Jupyter Integration**: Full Jupyter kernel support with rich output rendering
- **Modern Features**: Image/plot rendering, LaTeX support, virtual text output
- **Data Science Focus**: Designed specifically for scientific Python workflows
- **Future-Proof**: Built for modern Neovim with ongoing feature development

### Migration Benefits:
- Rich output display (images, plots, dataframes) directly in Neovim
- Better Jupyter notebook-like experience
- More robust kernel management
- Enhanced virtual environment support
- Modern Neovim integration (floating windows, virtual text)

### Migration Requirements:
- Neovim 9.4+
- Python 3.10+
- Optional: image.nvim for image rendering, kitty terminal for graphics protocol

### Current Status
**Current iron.nvim setup works well**, but if issues arise or advanced features are needed, molten-nvim provides a comprehensive upgrade path.

### Migration Steps (when ready):
1. Replace `Vigemus/iron.nvim` with `benlubas/molten-nvim`
2. Update dependencies (remove textobj plugins, add jupyter)
3. Reconfigure keymaps to molten equivalents
4. Optional: Add image.nvim for rich output rendering