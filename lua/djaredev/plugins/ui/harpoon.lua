return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    config = function()
        local harpoon = require("harpoon")
        -- REQUIRED
        harpoon:setup()
        -- REQUIRED
        vim.keymap.set("n", "<leader>H", function() harpoon:list():add() end, {desc = "Add Harpoon to buffer"})
        vim.keymap.set("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, {desc = "Harpoon quick menu"})
        vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, {desc = "Harpoon to buffer 1"})
        vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, {desc = "Harpoon to buffer 2"})
        vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, {desc = "Harpoon to buffer 3"})
        vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, {desc = "Harpoon to buffer 4"})
        require("which-key").add({"<leader>r", group = "Replace at Harpoon"})
        -- wk.add({"<leader>f", group = "Find/Search"})
        vim.keymap.set("n", "<leader>r1", function() harpoon:list():replace_at(1) end, {desc = "Replace at Harpoon 1"})
        vim.keymap.set("n", "<leader>r2", function() harpoon:list():replace_at(2) end, {desc = "Replace at Harpoon 2"})
        vim.keymap.set("n", "<leader>r3", function() harpoon:list():replace_at(3) end, {desc = "Replace at Harpoon 3"})
        vim.keymap.set("n", "<leader>r4", function() harpoon:list():replace_at(4) end, {desc = "Replace at Harpoon 4"})
    end
}