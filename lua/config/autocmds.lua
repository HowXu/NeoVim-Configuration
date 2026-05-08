-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
-- 自动为新建的 Java 文件生成 package 和 class 声明
vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "*.java",
  callback = function(opts)
    -- 获取去掉了后缀的文件名（即类名）
    local filename = vim.fn.expand("%:t:r")
    -- 获取文件所在的目录绝对路径，并将 Windows 的反斜杠统一替换为正斜杠
    local dir = vim.fn.expand("%:p:h"):gsub("\\", "/")

    -- 解析 package 路径
    local package_name = ""
    local src_main_java = "src/main/java/"
    local start_idx = dir:find(src_main_java)

    if start_idx then
      -- 提取 src/main/java/ 后面的部分，并将 '/' 替换为 '.'
      package_name = dir:sub(start_idx + #src_main_java):gsub("/", ".")
    else
      -- 兼容非标准 Maven 目录（例如简单的 src/ 目录结构）
      local src_idx = dir:find("src/")
      if src_idx then
        package_name = dir:sub(src_idx + 4):gsub("/", ".")
      end
    end

    -- 构建要插入的代码行
    local lines = {}
    if package_name ~= "" then
      table.insert(lines, "package " .. package_name .. ";")
      table.insert(lines, "")
    end

    table.insert(lines, "public class " .. filename .. " {")
    table.insert(lines, "    ") -- 预留一行缩进
    table.insert(lines, "}")

    -- 将代码写入当前的 buffer
    vim.api.nvim_buf_set_lines(opts.buf, 0, -1, false, lines)

    -- 使用 vim.schedule 确保在文件完全打开后，将光标移动到大括号内部
    vim.schedule(function()
      vim.api.nvim_win_set_cursor(0, { #lines - 1, 4 })
    end)
  end,
})
