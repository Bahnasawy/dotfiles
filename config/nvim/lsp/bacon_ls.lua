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

vim.lsp.enable("rust-analyzer", false)

function os.capture(cmd, raw)
  local handle = assert(io.popen(cmd, "r"))
  local output = assert(handle:read("*a"))

  handle:close()

  if raw then
    return output
  end

  output = string.gsub(string.gsub(string.gsub(output, "^%s+", ""), "%s+$", ""), "[\n\r]+", " ")

  return output
end

local file = io.open(os.capture("git rev-parse --show-toplevel") .. "/src/main.rs", "r")
if file ~= nil then
  local content = file:read("*a")
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
end
