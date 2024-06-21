local ts_utils = require("nvim-treesitter.ts_utils")
local api = vim.api

local ts = function(value)
	print(vim.inspect(value))
end

local position = ts_utils.get_node_at_cursor()
if position ~= nil then
	ts(position:parent())
end
