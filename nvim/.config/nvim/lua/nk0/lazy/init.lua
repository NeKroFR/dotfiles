local M = {}

-- Get directory of this file
local dir = debug.getinfo(1, "S").source:sub(2):match("(.*/)")
local handle = vim.loop.fs_scandir(dir)

while handle do
  local name, t = vim.loop.fs_scandir_next(handle)
  if not name then break end
  -- Only require .lua files, skip init.lua itself, and skip subdirs
  if name:sub(-4) == ".lua" and name ~= "init.lua" and t == "file" then
    local modname = "nk0.lazy." .. name:sub(1, -5) -- strip ".lua"
    local ok, spec = pcall(require, modname)
    if ok and spec then
      table.insert(M, spec)
    else
      vim.notify("Failed loading " .. modname, vim.log.levels.WARN)
    end
  end
end

return M

