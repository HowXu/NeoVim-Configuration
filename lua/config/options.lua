-- 关闭动态行
vim.opt.relativenumber = false
vim.opt.number = true
-- theme
-- vim.cmd.colorscheme("kanagawa")

-- 静默LSP消息
vim.lsp.handlers["$/progress"] = function() end

-- 缩进长度
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
-- 关闭自动折叠
vim.opt.textwidth = 0
vim.opt.formatoptions:remove("a")
vim.opt.foldmethod = "manual"
vim.opt.foldenable = false
-- 关闭自动格式化
vim.g.autoformat = false
-- 自动保存
local save_timer
vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
  pattern = "*",
  callback = function()
    if vim.bo.buftype ~= "" then return end
    if save_timer then pcall(vim.uv.close,save_timer) end
    save_timer = vim.defer_fn(function()
      if vim.fn.expand("%") ~= "" and vim.bo.modified then
        vim.cmd("silent write")
      end
    end, 5000)
  end,
})

-- 全部block光标
vim.opt.guicursor = "n-v-c-sm-i-ci-ve-r-cr-o:block"

