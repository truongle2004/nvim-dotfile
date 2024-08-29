local ts = vim.treesitter                          -- Access Tree-sitter functionality in Neovim
local parsers = require('nvim-treesitter.parsers') -- Import parser utility functions

local p = function(value)
    print(vim.inspect(value)) -- Define a utility function to print Lua tables in a readable format
end

local t = function(node)
    p(ts.get_node_text(node, 0)) -- Print the text of a node using Tree-sitter
end


-- Uncommented query skeleton for extracting variable declarators
-- local qs = [[
-- (variable_declarator
--         (object
--                 (pair
--                         key: (property_identifier) @prop)) @obj) @variable
-- ]]

-- local qs = [[]] -- Currently unused query placeholder

-- Get the current parser for the buffer and parse the syntax tree
local parser = parsers.get_parser()
-- local tree = parser:parse()[1]
-- local root = tree:root()
local lang = parser:lang() -- Retrieve the language of the parser, necessary for creating queries

--- Function to recursively get the parents of a Tree-sitter node
---@param child TSNode  -- The node whose parents are to be found
---@param results TSNode[]  -- An array to store the results
local function get_parents(child, results)
    local type = child:type()               -- Get the type of the current node
    assert(type == 'property_identifier')
    local parent = child:parent()           -- Get the parent of the node
    assert(parent:type() == 'pair')         -- Ensure the parent is of type 'pair'
    parent = parent:parent()                -- Get the parent of the 'pair' node
    local sib = parent:prev_named_sibling() -- Get the previous named sibling of the parent node
    assert(parent:type() == 'object')       -- Ensure the parent is of type 'object'
    table.insert(results, sib)
    if sib:type() == 'property_identifier' then
        return get_parents(sib, results)
    end
end

--- Function to log nodes based on a query
---@param node TSNode  -- The node to start logging from
local function logme(node)
    -- Parse a Tree-sitter query for the current language
    -- local query = ts.query.parse(lang, '(property_identifier) @prop ')
    -- Iterate over all captures of the query in the parent node


    local prop_nodes = { node }

    get_parents(node, prop_nodes) -- Find and log parents of each captured node

    for _, node in ipairs(prop_nodes) do
        t(node)
    end
    -- for _, node, _ in query:iter_captures(node:parent(), 0) do
    --     local prop_nodes = { node }
    --     get_parents(node) -- Find and log parents of each captured node
    --     for _, node in ipairs(prop_nodes) do
    --         t(node)
    --     end
    -- end
end

local current_node = ts.get_node() -- Get the current Tree-sitter node under the cursor
logme(current_node)                -- Run the logging function starting from the current node
