local M = {}


---@param cmd table
---@param opts table is a table with these keys:
  -- title: (string or nil) Notification's title.
  -- on_finish: (function, default=nil) Attach to on_exit.
function M.async_run(cmd, opts)

  local function on_event(_, data, event)
    if #data ~= 1 then
      vim.schedule(function()
        vim.notify(table.concat(data):gsub("\r", "\n"),
          -- Log level 2 -> INFO, 4 -> ERROR.
          (event == "stdout" and 2) or 4,
          {title = opts.title}
        )
      end)
    end
  end

  vim.fn.jobstart(cmd, {
    on_stdout = on_event,
    on_stderr = on_event,
    on_exit = opts.on_finish,
    stdout_buffered = true,
    stderr_buffered = true,
  })
end

M.toggle_qf = function()
  local qf_exists = false
  for _, win in pairs(vim.fn.getwininfo()) do
    if win["quickfix"] == 1 then
      qf_exists = true
      break
    end
  end
  if qf_exists then
    vim.cmd.cclose()
  elseif not vim.tbl_isempty(vim.fn.getqflist()) then
    vim.cmd.copen()
  end
end

M.untrigger = function()
  -- get the snippet
  local snip = require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()].parent.snippet
  -- get its trigger
  local trig = snip.trigger
  -- replace that region with the trigger (see :h nvim_buf_set_text)
	local node_from, node_to = snip.mark:pos_begin_end_raw()
	vim.api.nvim_buf_set_text(
		0,
		node_from[1],
		node_from[2],
		node_to[1],
		node_to[2],
		{ trig }
	)
  -- reset the cursor-position to ahead the trigger?
  vim.fn.setpos(".", { 0, node_from[1] + 1, node_from[2] + 1 + string.len(trig) })
end


return M
