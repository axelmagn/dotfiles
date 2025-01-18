-- define your colorscheme here
local colorscheme = 'monokai_pro'
-- local colorscheme = 'monokai'

-- use colorscheme *if* it's installed
local is_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not is_ok then
    vim.notify('colorscheme ' .. colorscheme .. ' not found!')
    return
end
