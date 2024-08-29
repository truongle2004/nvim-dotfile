local parsers = require('nvim-treesitter.parsers') -- Import parser utility functions
local ts_utils = require('nvim-treesitter.ts_utils')
local ts_source = require('treesitter-utils.init')



local M = {}

local t = function(value)
    print(vim.inspect(value))
end

-- local parser = parsers.get_parser()

local node = ts_utils.get_node_at_cursor()

-- Function to recursively check nodes for function types
local function check_node_and_children(node)
    if not node then return end

    -- Get the type of the current node
    local node_type = node:type()

    if node_type == "function_declaration" then
        print("Found a regular function declaration.")
    elseif node_type == "arrow_function" then
        print("Found an arrow function.")
    end

    -- Recursively check all children nodes
    for child in node:iter_children() do
        check_node_and_children(child)
    end
end


-- Function to get all values inside an arrow function node
local function get_arrow_function_at_cursor()
    -- Get the current node under the cursor
    local node = ts_utils.get_node_at_cursor()
    

    if not node then
        print("No node found under the cursor.")
        return
    end

    -- Check if the node is an arrow function
    if node:type() == "arrow_function" then
        local start_row, start_col, end_row, end_col = ts_utils.get_node_range(node)
        local text = vim.treesitter.get_node_text(node, 0)
        print(string.format("Arrow function found from line %d, column %d to line %d, column %d", start_row + 1,
            start_col + 1, end_row + 1, end_col + 1))
        print("Arrow function text:", text)
    else
        print("The node under the cursor is not an arrow function.")
    end
end

local function find_arrow_function_nearest()
    -- Get the current node under the cursor
    local node = ts_utils.get_node_at_cursor()

    if not node then
        print("No node found under the cursor.")
        return
    end

    -- Traverse up the tree to find the nearest arrow function
    while node do
        if node:type() == "arrow_function" then
            local start_row, start_col, end_row, end_col = ts_utils.get_node_range(node)
            local text = vim.treesitter.get_node_text(node, 0)
            local res = {}
            for i = 1, #text do
                local char = text:sub(i, i)
                t(char)
            end
            -- print(string.format("Arrow function found from line %d, column %d to line %d, column %d", start_row + 1,
            --     start_col + 1, end_row + 1, end_col + 1))
            -- print("Arrow function text:", text)
            return
        end

        -- Move to the parent node
        node = node:parent()
    end

    print("No arrow function found in the parent nodes.")
end


local function modify_and_replace_node_text()
    -- Get the current node under the cursor
    local node = ts_utils.get_node_at_cursor()

    if not node then
        print("No node found under the cursor.")
        return
    end

    -- Get the buffer number
    local bufnr = vim.api.nvim_get_current_buf()

    -- Get the range of the node (start and end positions)
    local start_row, start_col, end_row, end_col = ts.get_node_range(node)

    -- Get the original text of the node
    local original_text = vim.treesitter.get_node_text(node, 0)

    -- Modify the text as needed
    -- Example: Convert the text to uppercase
    local modified_text = original_text:upper()

    -- Replace the original text with the modified text in the buffer
    vim.api.nvim_buf_set_text(bufnr, start_row, start_col, end_row, end_col, { modified_text })

    print("Text has been modified and replaced.")
end


return M
