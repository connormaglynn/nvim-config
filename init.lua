-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

local copilot_chat = {
  buf = nil,
  win = nil,
}

function _G.toggle_copilot_chat_split()
  if copilot_chat.win and vim.api.nvim_win_is_valid(copilot_chat.win) then
    vim.api.nvim_win_close(copilot_chat.win, true)
    copilot_chat.win = nil
    return
  end

  local width = math.floor(vim.o.columns * 0.4)

  local file_dir = vim.fn.expand("%:p:h")
  local git_root = vim.fn.systemlist({ "git", "-C", file_dir, "rev-parse", "--show-toplevel" })[1]
  local cwd = (vim.v.shell_error == 0 and git_root and git_root ~= "") and git_root or vim.fn.getcwd()

  vim.cmd("botright vsplit")
  vim.cmd("vertical resize " .. width)
  vim.cmd("enew")

  copilot_chat.win = vim.api.nvim_get_current_win()
  copilot_chat.buf = vim.api.nvim_get_current_buf()

  vim.fn.termopen({ "gh", "copilot" }, {
    cwd = cwd,
  })

  vim.bo[copilot_chat.buf].buflisted = false
  vim.bo[copilot_chat.buf].bufhidden = "wipe"
  vim.cmd("startinsert")
end

vim.keymap.set("n", "<leader>ac", toggle_copilot_chat_split, {
  desc = "Toggle Copilot chat split",
})

vim.keymap.set("t", "<leader>ac", function()
  vim.cmd("stopinsert")
  toggle_copilot_chat_split()
end, {
  desc = "Toggle Copilot chat split",
})

vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]])
vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-w>j]])
vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-w>k]])
vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]])
