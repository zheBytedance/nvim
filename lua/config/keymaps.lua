-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- keymap({mode}, {lhs}, {rhs}, {opts})
-- {mode} mode where the keybinding should execute. It can be a list of modes. We need to specify the mode's short name. Here are some of the most common.
-- n: Normal mode.
-- i: Insert mode.
-- x: Visual mode.
-- s: Selection mode.
-- v: Visual + Selection.
-- t: Terminal mode.
-- o: Operator-pending.
-- '': Yes, an empty string. Is the equivalent of n + v + o
-- others options check https://vonheikemen.github.io/devlog/tools/build-your-first-lua-config-for-neovim/
local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Do not yank when paste
keymap("v", "p", '"_dp', opts)

-- You probably also want to set a keymap to toggle aerial
keymap("n", "<leader>O", "<cmd>AerialToggle!<CR>")

-- copy and paste from system clipboard
keymap({ "n", "x" }, "cp", '"+y')
keymap({ "n", "x" }, "cv", '"+p')
-- modify x to delete text without changing the internal registers.
keymap({ "n", "x" }, "x", '"_x')
-- select all text in current buffer
keymap("n", "<leader>a", ":keepjumps normal! ggVG<cr>")

-- delete all the trailing whitespace
-- keymap('n', '<leader>cc', ':keepjumps %s/\\s\\+$//e<CR>', {desc = 'del trailing space'})
-- keymap('n', '<leader>cc', "! sed -i e :a -e '/./,$!d;/^\n*$/{$d;N;};/\n$/ba' file", {desc = 'del trailing space'})
-- add -i '' to make this command work both for linux and macos
keymap("n", "<leader>cc", "! sed -i '' 's/[ \t]*$//' %<CR>", { desc = "del trailing space" })

-- Jump between register q and d
keymap("n", "<leader>rq", "/<C-R>/<BS><BS><BS>q<CR>", { desc = "jump to reg_q" })
keymap("n", "<leader>rd", "/<C-R>/<BS><BS><BS>d<CR>", { desc = "jump to reg_d" })
-- add _i and _o to all signal
keymap("n", "<leader>ri", ":%s/<C-R>//\\0_i/ge<CR>", { desc = "add _i" })
keymap("n", "<leader>ro", ":%s/<C-R>//\\0_o/ge<CR>", { desc = "add _o" })

-- An recursive keybinding example, but avoid using this, may cause conflicts
-- keymap('n', '<F2>', '<cmd>Lexplore<cr>')
-- keymap('n', '<space><space>', '<F2>', {remap = true})
-- run cog and verilog mode
keymap(
  "n",
  "<F5>",
  "! python ~/anaconda3/pkgs/cogapp*/bin/cog.py -r %<CR> ! emacs -l /fpga/scripts/verilog-mode/.emacs --batch % -f verilog-batch-auto<CR> ! sed -i 's/[ \t]*$//' %<CR>"
)
