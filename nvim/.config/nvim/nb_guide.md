# Neovim Notebook Setup

Simple guide for using Jupyter notebooks in Neovim with Molten + Jupytext.

## Two Ways to Setup

### Option 1: Global Virtual Environment

```bash
mkdir ~/.virtualenvs
python -m venv ~/.virtualenvs/neovim
source ~/.virtualenvs/neovim/bin/activate

pip install pynvim jupyter_client jupytext ipykernel cairosvg plotly kaleido
```

### Option 2: Project Virtual Environment

```bash
cd your-project
python -m venv .venv
source .venv/bin/activate

pip install ipykernel pynvim jupyter_client jupytext
python -m ipykernel install --user --name your_project
```

## Quick Start

1. **Open a notebook**: `nvim notebook.ipynb`
2. **Initialize kernel**: `:MoltenInit python3`
3. **Run code**: Position cursor on a code line (NOT on the fence) and use keymaps below

## Keymaps

| Key | Action |
|-----|--------|
| `<leader>mi` | Initialize kernel |
| `<leader>rl` | Evaluate current line |
| `<leader>rr` | Re-evaluate cell |
| `<leader>rd` | Delete cell output |
| `<leader>e` | Evaluate operator (visual mode) |
| `<leader>os` | Open output window |
| `<leader>oh` | Hide output window |
| `<leader>ri` | Interrupt kernel |

**Visual mode:**
- Select text and press `<leader>r` to evaluate selection

## Copying Output

1. Press `<leader>os` to open output window
2. Navigate to output buffer
3. Yank normally with `yy` or visual select + `y`

## Important Notes

- **Cursor position**: Always run code with cursor on a code line, NOT on the ` ```python ` fence line
- **Treesitter**: For best experience, install parsers:
  ```vim
  :TSInstallSync markdown markdown_inline python
  ```

## Switching Between Envs

- **Global env**: `source ~/.virtualenvs/neovim/bin/activate && nvim`
- **Project env**: Activate project venv, then `:MoltenInit your_project`

## Troubleshooting

```vim
:MoltenAvailableKernels  " List available kernels
:MoltenInit python3      " Initialize python3 kernel
:MoltenInit your_project " Initialize project kernel
:MoltenStatus            " Check kernel status
```
