local a = require 'plenary.async'
local async, await = a.async, a.await
local cli = require('neogit.lib.git.cli')
local util = require('neogit.lib.util')

local M = {}

local update_unmerged = function (state)
  if not state.upstream.branch then return end

  local result = 
  cli.log.oneline.for_range('@{upstream}..').show_popup(false).call()

  state.unmerged.files = util.map(result, function (x) 
    return { name = x } 
  end)
end

function M.register(meta)
  meta.update_unmerged = update_unmerged
end

return M
