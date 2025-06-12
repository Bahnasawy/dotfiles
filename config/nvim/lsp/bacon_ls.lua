-- bacon_ls = function(_)
--           local f = io.open(vim.fn.getcwd() .. "/src/main.rs", "r")
--           print(vim.fn.getcwd() .. "/src/main.rs")
--           if f then
--             local main_rs = string.find(f:read("*a"), "windows")
--             if main_rs ~= nil then
--               require("lspconfig").bacon_ls.setup({
--                 filetype = "rust",
--                 cmd = { "bacon-ls" },
--                 init_options = {
--                   runBaconInBackgroundCommandArguments = "--headless --job bacon-ls-win",
--                 },
--               })
--             else
--               require("lspconfig").bacon_ls.setup({
--                 filetype = "rust",
--                 cmd = { "bacon-ls" },
--                 init_options = {
--                   runBaconInBackgroundCommandArguments = "--headless --job bacon-ls",
--                 },
--               })
--             end
--             f:close()
--           end
--         end

local content = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false))
if string.find(content, "windows") then
  vim.lsp.config("bacon_ls", {
    init_options = {
      runBaconInBackgroundCommandArguments = "--headless --job bacon-ls-win",
    },
  })
else
  vim.lsp.config("bacon_ls", {
    init_options = {
      runBaconInBackgroundCommandArguments = "--headless --job bacon-ls",
    },
  })
end
