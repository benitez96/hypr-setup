local autocmd = vim.api.nvim_create_autocmd

-- Highlight yank
autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})

-- Auto-create directory on save
autocmd("BufWritePre", {
  callback = function(args)
    local dir = vim.fn.fnamemodify(args.file, ":p:h")
    vim.fn.mkdir(dir, "p")
  end,
})

-- Trim trailing whitespace on save
autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    local save_cursor = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", save_cursor)
  end,
})

-- Auto close certain brackets
autocmd("FileType", {
  pattern = { "json", "jsonc", "yaml", "yml" },
  callback = function()
    vim.opt.tabstop = 2
    vim.opt.shiftwidth = 2
  end,
})

-- Set filetype for common extensions
autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.env", ".env.*" },
  callback = function()
    vim.bo.filetype = "sh"
  end,
})
