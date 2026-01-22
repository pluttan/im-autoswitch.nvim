-- im-autoswitch.nvim
-- Auto-switch keyboard layout: English in Normal mode, restore in Insert mode

local M = {}

M.config = {
    im_select_command = "/usr/local/bin/im-select",
    default_im = "com.apple.keylayout.US",
    set_previous_im_on_enter = true,
}

local saved_im = nil

local function get_current_im()
    local result = vim.fn.system(M.config.im_select_command)
    return vim.trim(result)
end

local function set_im(im)
    if im and im ~= "" then
        vim.fn.system(M.config.im_select_command .. " " .. im)
    end
end

function M.save_and_switch_to_default()
    local current = get_current_im()
    -- Only save if it's not the default (to avoid saving English as "previous")
    if current ~= M.config.default_im then
        saved_im = current
    end
    set_im(M.config.default_im)
end

function M.restore_saved_im()
    if saved_im and M.config.set_previous_im_on_enter then
        set_im(saved_im)
    end
end

function M.setup(opts)
    M.config = vim.tbl_deep_extend("force", M.config, opts or {})

    -- Switch to default IM on startup
    set_im(M.config.default_im)

    local group = vim.api.nvim_create_augroup("ImAutoswitch", { clear = true })

    local function should_switch()
        local mode = vim.fn.mode()
        if mode == "c" then
            return false
        end
        -- Ignore telescope and other floating windows
        local buftype = vim.bo.buftype
        local filetype = vim.bo.filetype
        if buftype == "prompt" or buftype == "nofile" then
            return false
        end
        if filetype:match("^Telescope") or filetype:match("^telescope") then
            return false
        end
        return true
    end

    -- Save current layout and switch to default when leaving Insert
    vim.api.nvim_create_autocmd("InsertLeave", {
        group = group,
        callback = function()
            if not should_switch() then
                return
            end
            M.save_and_switch_to_default()
        end,
    })

    -- Restore saved layout when entering Insert (but not cmdline/telescope)
    vim.api.nvim_create_autocmd("InsertEnter", {
        group = group,
        callback = function()
            if not should_switch() then
                return
            end
            M.restore_saved_im()
        end,
    })
end

return M
