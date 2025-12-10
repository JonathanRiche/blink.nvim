local blink = require("blink")
-- Define the command handler function
local handler = function(opts)
  -- 'opts' is the table automatically passed by Neovim containing command details.
  -- The user-provided arguments are in opts.fargs (fargs = filtered arguments).
  local item_id = opts.fargs[2]
  local account = opts.fargs[1]

  if not item_id then
    vim.notify("Error: :BlinkGetItem requires an argument (e.g., :BlinkGetItem 3)", vim.log.levels.ERROR)
    return
  end

  -- Call your main module function with the extracted argument
  local result = blink.get_item(account, item_id)

  -- Display the result (or handle errors if not handled inside get_item)
  if result then
    vim.print(result)
    local json_string = vim.json.encode(result)
    vim.fn.setreg("+", json_string)
    vim.notify("Successfully retrieved item " .. item_id .. " and copied JSON to clipboard!", vim.log.levels.INFO)
  end
end
-- Create the user command
vim.api.nvim_create_user_command(
  "BlinkGetItem", -- Command Name
  handler, -- The wrapper function defined above
  {
    nargs = "+", -- Tell Neovim to expect exactly 1 argument
    desc = "Get a specific item by ID and account",
  }
)
-- vim.api.nvim_create_user_command("BlinkGetItem", require("blink").get_item, {})
