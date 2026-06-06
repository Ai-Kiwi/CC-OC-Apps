term.clear()
local termsize = {}
termsize.x, termsize.y = term.getSize()
local NormalTerm = term.current()
local AppsOpen = {}
local AppDisplayedOnScreen = {}
local OnlyMainAppFilters = { ["char"] = true, ["key"] = true, ["key_up"] = true, ["mouse_click"] = true, ["mouse_drag"] = true, ["mouse_scroll"] = true, ["mouse_up"] = true, ["paste"] = true}

--sytem for vfs is setup so every app has 1 file that has all its data in it


 -- isDriveRoot(path)
 -- complete(path, location [, include_files [, include_dirs]])
 -- list(path)
 -- combine(path, ...)
 -- getName(path)
 -- getDir(path)
 -- getSize(path)
 -- exists(path)
 -- isDir(path)
 -- isReadOnly(path)
 -- makeDir(path)
 -- move(path, dest)
 -- copy(path, dest)
 -- delete(path)
 -- open(path, mode)
 -- getDrive(path)
 -- getFreeSpace(path)
 -- find(path)
 -- getCapacity(path)
 -- attributes(path)



local function CoroutineLoadApp()
    shell.run("test.lua")
end

local function LoadApp(AppPath)
    local App = fs.open(AppPath, "r")
    local AppData = App.readAll()
    App.close()
    local AppData = textutils.unserialize(AppData)
    local NewCoroutine = coroutine.create(function() shell.run("test.lua") end )
    local NewWindow = window.create(term.native(), 1, 1, termsize.x, termsize.y, false)
    print(NewCoroutine)
    table.insert(AppsOpen, {
        ZPD = AppData,
        coroutine = NewCoroutine,
        window = NewWindow,
        WindowOnScreen = false
    })
    
end


debug = nil
LoadApp("test.zpd")


--this needs to have the following
--some apps can read things like text even tho in background
--different things like alarms for all apps
--also add support for term_resize when things like side menu moved to
--also have terminate
local function tickApp(APPID,EVENT)
    if OnlyMainAppFilters[EVENT[1]] == true and AppDisplayedOnScreen[APPID] == nil then
        return
    end

    term.redirect(AppsOpen[APPID].window)

    if AppDisplayedOnScreen[APPID] ~= nil then
        AppsOpen[APPID].window.setVisible(true)
        if WindowOnScreen == false then
            WindowOnScreen = true
            AppsOpen[APPID].window.redraw()
        end
    else
        AppsOpen[APPID].window.setVisible(false)
        WindowOnScreen = false
    end
    


    coroutine.resume(AppsOpen[1].coroutine,unpack(EVENT))

end


while true do
    local event = {os.pullEventRaw()}


    for i,v in pairs(AppsOpen) do
        tickApp(i,event)
    end
    term.redirect(NormalTerm)
    
    if event[1] == "key" and event[2] == keys.home then
        AppDisplayedOnScreen = {}
        AppDisplayedOnScreen[1] = true
    end
            

end
