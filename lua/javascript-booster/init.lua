local parsers = require("nvim-treesitter.parsers") -- Import parser utility functions
local ts_utils = require("nvim-treesitter.ts_utils")
local ts_source = require("treesitter-utils.init")
local ts = vim.treesitter

local M = {}

local t = function(value)
    print(vim.inspect(value))
end

-- local parser = parsers.get_parser()

local node = ts_utils.get_node_at_cursor()

-- Function to recursively check nodes for function types
local function check_node_and_children(node)
    if not node then
        return
    end

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
        print(
            string.format(
                "Arrow function found from line %d, column %d to line %d, column %d",
                start_row + 1,
                start_col + 1,
                end_row + 1,
                end_col + 1
            )
        )
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
            local bufnr = vim.api.nvim_get_current_buf()
            local start_row, start_col, end_row, end_col = ts_utils.get_node_range(node)
            local text = vim.treesitter.get_node_text(node, 0)

            -- Modify the text: wrap the arrow function in useCallback
            local modified_text = text:gsub("(%b())", function(args)
                return "useCallback(()" .. text:sub(args:len() + 1) .. ")"
            end)

            print(modified_text)
            -- Replace the original text with the modified text in the buffer
            -- vim.api.nvim_buf_set_text(bufnr, start_row, start_col, end_row, end_col, { modified_text })

            print("Arrow function text has been modified and replaced.")
            return
        end

        -- Move to the parent node
        node = node:parent()
    end

    print("No arrow function found in the parent nodes.")
end
find_arrow_function_nearest()

return M
