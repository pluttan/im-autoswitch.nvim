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
    local handle = io.popen(M.config.im_select_command)
    if handle then
        local result = handle:read("*a"):gsub("%s+", "")
        handle:close()
        return result
    end
    return nil
end

local function set_im(im)
    if im then
        os.execute(M.config.im_select_command .. " " .. im)
    end
end

function M.save_and_switch_to_default()
    saved_im = get_current_im()
    set_im(M.config.default_im)
end

function M.restore_saved_im()
    if saved_im and M.config.set_previous_im_on_enter then
        set_im(saved_im)
    end
end

function M.setup(opts)
    M.config = vim.tbl_deep_extend("force", M.config, opts or {})

    local group = vim.api.nvim_create_augroup("ImAutoswitch", { clear = true })

    -- Save current layout and switch to default when leaving Insert
    vim.api.nvim_create_autocmd("InsertLeave", {
        group = group,
        callback = M.save_and_switch_to_default,
    })

    -- Restore saved layout when entering Insert
    vim.api.nvim_create_autocmd("InsertEnter", {
        group = group,
        callback = M.restore_saved_im,
    })

    -- Also handle CmdlineLeave for command mode
    vim.api.nvim_create_autocmd("CmdlineLeave", {
        group = group,
        callback = M.save_and_switch_to_default,
    })

    vim.api.nvim_create_autocmd("CmdlineEnter", {
        group = group,
        callback = M.restore_saved_im,
    })
end

return M
