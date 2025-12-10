---@class CustomModule
local M = {}

---@return string
M.my_first_function = function(greeting)
  return greeting
end

M.blink_get_item = function(account, item_id)
  local command = {
    "blinkx",
    "--account",
    account,
    "content get",
    item_id,
  }
  -- local result = vim.fn.system(command)

  local raw_command = table.concat(command, " ")
  local shell_command = raw_command .. " 2>&1"
  local result = vim.fn.system(shell_command)

  local exit_code = vim.v.shell_error
  if exit_code ~= 0 then
    -- Handle the error: 'result' now contains the error message from stderr
    vim.notify(
      "blink-cli failed (Code: " .. exit_code .. ")\nOutput/Error:\n" .. result,
      vim.log.levels.ERROR,
      { title = "blink.nvim CLI Error" } -- Use a title for better display
    )
    return nil -- Return early on failure
  end
  if result and result ~= "" then
    -- Assuming your CLI returns JSON
    local success, data = pcall(vim.json.decode, result)
    if success then
      return data
    else
      vim.notify("Failed to parse JSON from blink-cli output.", vim.log.levels.ERROR)
      return nil
    end
  end
end

return M
