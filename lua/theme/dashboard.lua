return {
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = 
[[
NeoVim - Neo Vi Improved

版本 ]] .. vim.version().major .. "." .. vim.version().minor ..
[[

协作者 howxu 等 
NeoVim 是可自由分发的开放源代码软件

输入 : help       获取软件帮助
输入 : WhichKey   获取键盘映射
]],
        },
        sections = {
          -- 只保留header一个section
          { section = "header" },
        },
      },
    },
  },
}
