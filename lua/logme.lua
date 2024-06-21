local ts = vim.treesitter
local parsers = require("nvim-treesitter.parsers")

local p = function(value)
	print(vim.inspect(value)) -- convert into string
end

local t = function(node)
	p(ts.get_node_text(node, 0)) -- 0 select current buffer
end

local qs = [[ (property_identifier) @prop ]]
local parser = parsers.get_parser()
local tree = parser:parse()[1]
local root = tree:root()
local lang = parser:lang()

---@param child TSNode
---@param result TSNode
local function get_parents(child, result)
	local type = child:type()
	if type == "property_identifier" then
		local parent = child:parent()
		assert(parent:type() == "pair")
		parent = parent:parent()
	end

	if type == "pair" then
		-- do somethings
	end

	if type == "object" then
		-- do somethings
	end
end

---@param node TSNode
local function logme(node)
	node:type()
	local query = ts.query.parse(lang, qs)
	for _, node, _ in query:iter_captures(root, 0) do
		t(node)
	end
end

-- get current node at the cursor
local curr_node = ts.get_node()
t(curr_node)
