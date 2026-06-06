--get screen size

while true do
    --update taskbar to correct cords
    local Event, ScreenX, ScreenY = coroutine.yield("get_screen_size")

    coroutine.yield("set_window_size", ScreenX, 1)
    coroutine.yield("set_window_position", 1, ScreenY)
    
    term.setBackgroundColor(colors.white)
    term.setTextColor(colors.white)
    term.clear()
    --draw time at the end
    term.setCursorPos(ScreenX - 7, 1)
    term.setTextColor(colors.black)
    term.write(os.date("%H:%M:%S"))
    --draw app luancher icon
    term.setCursorPos(1, 1)
    term.setBackgroundColor(colors.lightGray)
    term.setTextColor(colors.black)
    term.write("KiwiOS")
    
    --draw apps
    local NewEvent, Apps = coroutine.yield("app_list")
    

    if Apps == nil or Event == "app_list_result" then
        term.setBackgroundColor(colors.red)
        term.setTextColor(colors.white)
        term.setCursorPos(7, 1)
        term.write("EGA")
    else
        for k,v in pairs(Apps) do
            term.setCursorPos(k + 7, 1)
            term.setBackgroundColor(colors.orange)
            term.setTextColor(colors.black)
            term.write(string.sub(v.Name, 1, 1))
        end
    end



    os.startTimer(1)
    local Event, Button, X, Y = os.pullEvent()
    if Event == "mouse_click" then
        --look if they are clicking on KiwiOS icon
        if X >= 1 and X <= 5 then
            --open app luancher
            coroutine.yield("open_new_app", "Start_Menu", "KiwiOS/sysapp/StartMenu.lua", 100, "3")
            --open_new_app <name> <path> <order> <WindowMode>

            
        end
            
    end
    
end







