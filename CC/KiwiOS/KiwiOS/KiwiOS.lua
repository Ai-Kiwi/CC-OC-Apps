--tests if its running on moblie
if false then
    coroutine.yield("open_new_app", "MobileUI", "KiwiOS/sysapp/MobileUI.lua", -100, "2")
else
    -- open_new_app <name> <path> <order> <WindowMode>
    coroutine.yield("open_new_app", "desktop", "KiwiOS/sysapp/desktop.lua", -250, "2")
    coroutine.yield("open_new_app", "taskbar", "KiwiOS/sysapp/taskbar.lua", 100, "3")
end

