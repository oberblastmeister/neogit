local popup = require("neogit.lib.popup")
local status = require 'neogit.status'
local notif = require("neogit.lib.notification")
local git = require("neogit.lib.git")
local a = require('neogit.async')

local function push_upstream(popup)
  a.dispatch(function ()
    local _, code = a.wait(git.cli.push.args(unpack(popup.get_arguments())).call())
    if code == 0 then
      a.wait_for_textlock()
      notif.create "Pushed to pushremote"
      status.refresh(true)
    end
  end)
end

local function create()
  popup.create(
    "NeogitPushPopup",
    {
      {
        key = "f",
        description = "Force with lease",
        cli = "force-with-lease",
        enabled = false
      },
      {
        key = "F",
        description = "Force",
        cli = "force",
        enabled = false
      },
      {
        key = "h",
        description = "Disable hooks",
        cli = "no-verify",
        enabled = false
      },
      {
        key = "d",
        description = "Dry run",
        cli = "dry-run",
        enabled = false
      },
    },
    {},
    {
      {
        {
          key = "p",
          description = "Push to pushremote",
          callback = push_upstream
        },
        {
          key = "u",
          description = "Push to upstream",
          callback = push_upstream
        },
        {
          key = "e",
          description = "Push to branch",
          callback = function() end
        }
      },
    })
end

return {
  create = create
}
