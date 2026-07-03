<div align="center">

# im-autoswitch.nvim

**Auto-switch keyboard layout in Neovim — English in Normal mode, your language in Insert**

</div>

A tiny Neovim plugin that keeps your keyboard layout sane when writing in non-Latin languages. Switches to English automatically when you leave Insert mode, and restores your previous layout when you come back.

## ■ Features

- ❖ **Automatic layout switch** — English on `<Esc>`, previous layout on `i`/`a`/`o`
- ❖ **Smart save** — only saves a non-English layout as "previous" (won't loop back to English)
- ❖ **Focus recovery** — restores English when Neovim regains focus in Normal/Visual mode
- ❖ **Telescope-aware** — skips switching in prompt and floating windows

## ■ Stack

<div align="center">

| Component | Technology |
|-----------|-----------|
| Plugin runtime | Neovim (Lua) |
| Layout switcher | im-select |
| Platform | macOS |

</div>

## ■ How It Works

```
1. On leaving Insert mode (<Esc>), the plugin records the current layout if it is non-English and calls im-select to activate the English layout.
2. On entering Insert mode (i/a/o), im-select restores the previously saved non-English layout.
3. When Neovim regains window focus while in Normal or Visual mode, the English layout is enforced again.
4. In Telescope prompt buffers and floating windows the switching logic is skipped entirely.
```

## ■ Usage

Requires macOS with [`im-select`](https://github.com/daipeihust/im-select):

```bash
curl -Ls https://raw.githubusercontent.com/daipeihust/im-select/master/install_mac.sh | sh
```

### lazy.nvim

```lua
{
    "pluttan/im-autoswitch.nvim",
    config = function()
        require("im-autoswitch").setup({
            -- defaults shown:
            im_select_command = "/usr/local/bin/im-select",
            default_im = "com.apple.keylayout.US",
            set_previous_im_on_enter = true,
        })
    end,
}
```

## ■ Configuration

<div align="center">

| Option | Default | Description |
|--------|---------|-------------|
| `im_select_command` | `/usr/local/bin/im-select` | Path to `im-select` binary |
| `default_im` | `com.apple.keylayout.US` | Layout to activate in Normal mode |
| `set_previous_im_on_enter` | `true` | Restore previous layout on Insert enter |
| `debug` | `false` | Print debug messages to `:messages` |

</div>

## ■ License

MIT © [pluttan](https://github.com/pluttan)
