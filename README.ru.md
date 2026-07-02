<div align="center">

# im-autoswitch.nvim

**Автопереключение раскладки в Neovim — English в Normal, ваш язык в Insert**

[![License](https://img.shields.io/badge/license-MIT-2C2C2C?style=for-the-badge&labelColor=1E1E1E)](LICENSE)
[![Lua](https://img.shields.io/badge/lua-5.1-2C2C2C?style=for-the-badge&logo=lua&labelColor=1E1E1E)]()
[![Neovim](https://img.shields.io/badge/neovim-0.8+-2C2C2C?style=for-the-badge&logo=neovim&labelColor=1E1E1E)]()

</div>

Маленький плагин для Neovim, который избавляет от проблемы с раскладкой при работе с нелатинскими языками. При выходе из Insert-режима автоматически переключается на English, при входе — восстанавливает предыдущую раскладку.

## ■ Возможности

- ❖ **Автоматическое переключение** — English при `<Esc>`, предыдущая раскладка при `i`/`a`/`o`
- ❖ **Умное сохранение** — запоминает только нелатинскую раскладку (не зацикливается на English)
- ❖ **Восстановление при фокусе** — возвращает English, когда Neovim получает фокус в Normal/Visual
- ❖ **Поддержка Telescope** — не переключает раскладку в prompt и плавающих окнах

## ■ Установка

Требуется macOS с установленным [`im-select`](https://github.com/daipeihust/im-select):

```bash
curl -Ls https://raw.githubusercontent.com/daipeihust/im-select/master/install_mac.sh | sh
```

### lazy.nvim

```lua
{
    "pluttan/im-autoswitch.nvim",
    config = function()
        require("im-autoswitch").setup({
            -- значения по умолчанию:
            im_select_command = "/usr/local/bin/im-select",
            default_im = "com.apple.keylayout.US",
            set_previous_im_on_enter = true,
        })
    end,
}
```

## ■ Настройка

| Параметр | По умолчанию | Описание |
|----------|--------------|----------|
| `im_select_command` | `/usr/local/bin/im-select` | Путь к бинарнику `im-select` |
| `default_im` | `com.apple.keylayout.US` | Раскладка для Normal-режима |
| `set_previous_im_on_enter` | `true` | Восстанавливать предыдущую раскладку при входе в Insert |
| `debug` | `false` | Выводить отладочные сообщения в `:messages` |

## ■ Лицензия

MIT © [pluttan](https://github.com/pluttan)
