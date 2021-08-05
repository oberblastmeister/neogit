local a = require 'plenary.async'
local uv = a.uv

local M = {}

M.read_file = function(path)
  local err, fd = uv.fs_open(path, "r", 438)
  if err then return err end

  local err, stat = uv.fs_fstat(fd)
  if err then return err end

  local err, data = uv.fs_read(fd, stat.size, 0)
  if err then return err end

  local err = uv.fs_close(fd)
  if err then return err end

  return nil, data
end

M.read_file_sync = function(path)
  local output = {}

  for line in io.lines(path) do
    table.insert(output, line)
  end

  return output
end

return M
