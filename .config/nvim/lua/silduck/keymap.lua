keymap.set("x", "J", ":m '>+1<CR>gv=gv")
keymap.set("x", "K", ":m '<-2<CR>gv=gv")

keymap.set("n", "J", "mzJ`z")
keymap.set({ "n", "x" }, "<C-d>", "<C-d>zz")
keymap.set({ "n", "x" }, "<C-u>", "<C-u>zz")
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

keymap.set("x", "<M-p>", [["_dp]])

keymap.set({ "n", "x" }, "<leader>y", [["+y]])
keymap.set("n", "<leader>Y", [["+Y]])

keymap.set({ "n", "x" }, "<M-d>", [["_d]])

keymap.set("n", "Q", "<nop>")

keymap.set("n", "<leader>r", [[:%s/<C-r><C-w>//g<Left><Left>]])

keymap.set("n", "<leader>x", "<CMD>!chmod +x %<CR>")
