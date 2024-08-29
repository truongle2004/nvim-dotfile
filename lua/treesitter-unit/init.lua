local ts_utils = require("nvim-treesitter.ts_utils")
local api = vim.api
local M = {}

local function t(value)
    print(vim.inspect(value))
end


local get_master_node = function()
    local node = ts_utils.get_node_at_cursor()
    -- retrieves the Treesitter directly under the curor

    if node == nil then
        error("No Treesitter parser found")
        -- check null
    end

    -- This line retrieves the root node of the syntax tree
    local root = ts_utils.get_root_for_node(node)

    -- This line gets the starting row (line number) of the node in the buffer
    local start_row = node:start()
    -- This line retrieves the parent node of the node.
    local parent = node:parent()

    while parent ~= nil and parent ~= root and parent:start() == start_row do
        node = parent
        parent = node:parent()
    end

    return node
end

M.select = function()
    local node = get_master_node()
    local bufnr = api.nvim_get_current_buf()
    ts_utils.update_selection(bufnr, node)
end

M.delete = function(for_change)
    local node = get_master_node()
    local bufnr = api.nvim_get_current_buf()
    local replaced = for_change and " " or ""
    local start_row, start_col, end_row, end_col = node:range()
    api.nvim_buf_set_text(bufnr, start_row, start_col, end_row, end_col, { replaced })
end

M.change = function()
    M.delete(true)
    vim.cmd("startinsert")
end


return M
