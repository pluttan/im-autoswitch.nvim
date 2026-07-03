<div align="center">

# im-autoswitch.nvim

**Автопереключение раскладки в Neovim — English в Normal, ваш язык в Insert**

</div>

Маленький плагин для Neovim, который избавляет от проблемы с раскладкой при работе с нелатинскими языками. При выходе из Insert-режима автоматически переключается на English, при входе — восстанавливает предыдущую раскладку.

## ■ Возможности

- ❖ **Автоматическое переключение** — English при `<Esc>`, предыдущая раскладка при `i`/`a`/`o`
- ❖ **Умное сохранение** — запоминает только нелатинскую раскладку (не зацикливается на English)
- ❖ **Восстановление при фокусе** — возвращает English, когда Neovim получает фокус в Normal/Visual
- ❖ **Поддержка Telescope** — не переключает раскладку в prompt и плавающих окнах

## ■ Стек

<div align="center">

| Компонент | Технология |
|-----------|-----------|
| Среда выполнения плагина | Neovim (Lua) |
| Переключатель раскладки | im-select |
| Платформа | macOS |

</div>

## ■ Как это работает

```
1. При выходе из Insert-режима (<Esc>) плагин запоминает текущую раскладку, если она нелатинская, и вызывает im-select для активации English.
2. При входе в Insert-режим (i/a/o) im-select восстанавливает сохранённую нелатинскую раскладку.
3. Когда Neovim получает фокус в Normal или Visual режиме, English-раскладка принудительно активируется снова.
4. В prompt-буферах Telescope и плавающих окнах логика переключения полностью пропускается.
```

## ■ Использование

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

## ■ Конфигурация

<div align="center">

| Параметр | По умолчанию | Описание |
|----------|-------------|----------|
| `im_select_command` | `/usr/local/bin/im-select` | Путь к бинарнику `im-select` |
| `default_im` | `com.apple.keylayout.US` | Раскладка для Normal-режима |
| `set_previous_im_on_enter` | `true` | Восстанавливать предыдущую раскладку при входе в Insert |
| `debug` | `false` | Выводить отладочные сообщения в `:messages` |

</div>

## ■ Лицензия

MIT © [pluttan](https://github.com/pluttan)
