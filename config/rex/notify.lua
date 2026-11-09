-- Turn a terminal bell in any session into a macOS notification.
-- Run with: rex do ~/.config/rex/notify.lua --all
local function notify(title, text)
  rex.exec{
    "osascript", "-e",
    string.format("display notification %q with title %q", text, title),
  }
end

rex.on("terminal.bell", function(ctx, ev)
  local view = rex.session.view{}
  notify("Rex", "Bell in " .. view.label)
end)
