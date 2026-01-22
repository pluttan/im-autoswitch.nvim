# im-autoswitch.nvim

Auto-switch keyboard layout for Neovim: English in Normal mode, restore previous layout in Insert mode.

## Requirements

- macOS with `im-select` installed:
  ```bash
  curl -Ls https://raw.githubusercontent.com/daipeihust/im-select/master/install_mac.sh | sh
  ```

## Installation

### lazy.nvim

```lua
{
    dir = "~/path/to/im-autoswitch.nvim",
    config = function()
        require("im-autoswitch").setup({
            -- Default settings:
            im_select_command = "/usr/local/bin/im-select",
            default_im = "com.apple.keylayout.US",
            set_previous_im_on_enter = true,
        })
    end,
}
```

## Configuration

| Option | Default | Description |
|--------|---------|-------------|
| `im_select_command` | `/usr/local/bin/im-select` | Path to im-select binary |
| `default_im` | `com.apple.keylayout.US` | Input method to use in Normal mode |
| `set_previous_im_on_enter` | `true` | Restore previous IM when entering Insert mode |

## How it works

1. When you leave Insert mode → saves current layout, switches to English
2. When you enter Insert mode → restores saved layout
3. Same behavior for Command-line mode

## License

MIT
