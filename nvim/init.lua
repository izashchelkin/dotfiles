require("config.lazy")

local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.shiftwidth = 4
opt.clipboard = "unnamedplus"
opt.ignorecase = true
opt.smartcase = true

local keymap = vim.keymap

keymap.set("n", "<leader><leader>f", function() vim.lsp.buf.format() end)

keymap.set("n", "<leader><leader>x", "<cmd>source %<CR>")
keymap.set("n", "<leader>x", ":.lua<CR>")
keymap.set("v", "<leader>x", ":lua<CR>")

keymap.set("n", "<M-j>", "<cmd>cnext<CR>")
keymap.set("n", "<M-k>", "<cmd>cprev<CR>")

keymap.set("n", "-", "<cmd>Oil<CR>")

keymap.set("n", "<esc>", ":noh<CR>")

keymap.set("n", "df", ":lua vim.diagnostic.open_float()<CR>")

local term_job_id;
local term_win;

keymap.set("n", "<leader>st", function()
  vim.cmd.vnew()
  term_win = vim.api.nvim_get_current_win()
  term_job_id = vim.fn.jobstart(vim.o.shell, { term = true })
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, 15)
end)

keymap.set("n", "<leader>rt", function()
  vim.api.nvim_chan_send(term_job_id, "\027[A")
  vim.api.nvim_chan_send(term_job_id, "\r")
  vim.api.nvim_win_call(term_win, function()
    vim.cmd("normal! G")
  end)
end)

vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end
})
