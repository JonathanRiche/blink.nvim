-- main module file
local module = require("blink.module")

---@class Config
---@field opt string Your config option
local config = {
  opt = "Hello!",
}

---@class MyModule
local M = {}

---@type Config
M.config = config

---@param args Config?
-- you can define your setup function here. Usually configurations can be merged, accepting outside params and
-- you can also put some validation here for those.
M.setup = function(args)
  M.config = vim.tbl_deep_extend("force", M.config, args or {})
end

M.hello = function()
  print(M.config.opt)
  return module.my_first_function(M.config.opt)
end

M.get_item = function(account, item_id)
  return module.blink_get_item(account, item_id)
end

return M
