# Neovim Config

this is the config i use for Neovim. it doesn't have many plugins, mainly just a colorscheme and lsp support.

## Requirements

make sure [ripgrep](https://github.com/BurntSushi/ripgrep) and [packer.nvim](https://github.com/wbthomason/packer.nvim) are installed.

## Setup

navigate to the [packer.nvim](lua/config/packer.lua) file and run these commands

```
:so
:PackerSync
```

if all went well, you should just have to restart nvim to see the changes

## future plans

eventually i might update this to use [lazy.nvim](https://github.com/folke/lazy.nvim) instead of packer since packer is no longer maintained.
