local ToasterTools = {}

local function app_list()
    Event, Apps = coroutine.yield("app_list")
    if Event == "app_list_result" then
        return Apps
    else
        return nil
    end
end
ToasterTools.app_list = app_list

local function SYSINFO()
    Event, SysInfo = coroutine.yield("sysinfo")
    if Event == "sysinfo_result" then
        return SysInfo
    else
        return nil
    end
end
ToasterTools.SYSINFO = SYSINFO

local function kill_app(AppName)
    Event, AppName = coroutine.yield("kill_app", AppName)
    if Event == "killed_app" then
        return AppName
    else
        return nil
    end
end
ToasterTools.kill_app = kill_app

local function get_screen_size()
    Event, ScreenSizeX, ScreenSizeY = coroutine.yield("get_screen_size")
    if Event == "got_screen_size" then
        return ScreenSizeX, ScreenSizeY
    else
        return nil
    end
end
ToasterTools.get_screen_size = get_screen_size

local function set_window_size(WindowSizeX, WindowSizeY)
    Event, WindowSizeX, WindowSizeY = coroutine.yield("set_window_size", WindowSizeX, WindowSizeY)
    if Event == "set_window_size" then
        return WindowSizeX, WindowSizeY
    else
        return nil
    end
end
ToasterTools.set_window_size = set_window_size

local function set_window_position(WindowPosX, WindowPosY)
    Event, WindowPosX, WindowPosY = coroutine.yield("set_window_position", WindowPosX, WindowPosY)
    if Event == "set_window_position" then
        return WindowPosX, WindowPosY
    else
        return nil
    end
end
ToasterTools.set_window_position = set_window_position

local function open_new_app(AppName)
    Event, AppName = coroutine.yield("open_new_app", AppName)
    if Event == "created_new_app" then
        return AppName
    else
        return nil
    end
end
ToasterTools.open_new_app = open_new_app

return ToasterTools